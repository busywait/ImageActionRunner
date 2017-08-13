:: Form a command line based on the arguments and environment variables, 
:: run the command, and then clear down the state built during this run.

:: CHECK THE COMMAND LINE

:: These scripts expect to receive all file and directory names to be processed
:: on a command line because that makes it possible to integrate these scripts
:: with image organizers and the Windows Send To menu. However, there are 
:: limits on the length that a command line can be. Commands launched from 
:: ACDSee Pro/Ultimate 10 are seen to truncate external editor commands at 
:: around (but not exactly, and sometimes more than) 2047 characters. File names 
:: always seem to be intact, and don't finish half way through.

:: The Windows File Explorer Send To feature in Windows 10 does not truncate at 
:: 2047 characters, but .cmd scripts like Exif Action Runner will not run if the 
:: number of files selected forms a command line over 8192(?) characters.

:: If we have got this far then the script is running so we have not hit the 8192 
:: character limit - we only need to warn if the command is at risk of having 
:: been truncated
@call :cmdlen cmdLength
@echo %cmdcmdline%
@echo Command Length: %cmdLength%
@if %cmdLength% geq 4095 (
	goto :no2047CharacterLimit
)
@if %cmdLength% geq 2000 (
	setlocal EnableDelayedExpansion
	echo WARNING: It looks like the list of files to process might have been truncated. 
	echo Review the command above - you will need to process any remaining files seperately. 
	echo Also consider putting all of the files in the same directory and running your action 
	echo on the directory, or using an action shortcut in the Windows File Explorer Send To 
	echo which supports a longer file list and running actions on folders. 
	set /p response="Press return to continue, enter q stop and choose a smaller set of files, or f to run the action on all files in folder %~dp1 : "

	if "q"=="!response!" (
		goto :cleanUpAndFinish
	)
	if "f"=="!response!" (
		goto :processWholeFolderInsteadOfFileSelection
	)
:no2047CharacterLimit	
	endlocal
)	

:: Only set the sidecar_mode if the calling script did not pass it in
@if NOT DEFINED sidecar_mode call :setSidecarMode $*

:: The caller can force these scripts to never look for sidecar files,
:: but by default we will update any existing sidecar when it exists 
@if [%sidecar_mode%]==[ignore] (
	set runner=_exiftoolNoSidecarSearch.bat
	) else ( 
	set runner=_exiftoolLookForSidecars.bat
)
@call "%runner_dir%%runner%" %action_params% %*

:cleanUpAndFinish
@call "%runner_dir%_clearRunState.bat"
@exit /b

:: If the command line looks like it has been truncated, then maybe 
:: it is appropriate to run the command on the whole folder?
:: This is useful if all files are in the same folder already
:: because ACDSee image manager does not allow external editors to be 
:: run on a folder.
:processWholeFolderInsteadOfFileSelection
@	set runner=_exiftoolNoSidecarSearch.bat
@if EXIST "%~1\*" (
	echo "The first item in your list is a folder, %~1."
	echo "Processing the parent folder of a list of folders is not supported."
	goto :cleanupAndFinish
	) else ( 
	call "%runner_dir%%runner%" %action_params% "%~dp1."
)
:: Append . at the end of %~dp1. (above) because exiftool fails to process a folder path if it ends in \
:: 
:: .bat files only allow one comment line per code block (above) !
@goto :cleanUpAndFinish
@exit /b

:setSidecarMode
:: If we've been passed a directory instead of a file list then ask exiftool to
:: process every writable file. No need to look for sidecar files in this case.
:: Otherwise use exiftool to act on related sidecar files as well as the base files.
@if EXIST "%~1\*" (
	:: only process files passed explicitly to exiftool
	set "sidecar_mode=ignore"
	) else ( 
	:: as well as processing the given file, look to see if there is a related sidecar
	set "sidecar_mode=look" )
::! .bat files only allow one comment line per code block (above) !
@exit /b

:cmdlen <resultVar>
@(
@	setlocal EnableDelayedExpansion
@	set "s=!%cmdcmdline%!#"
@	set "len=0"
@	for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
@		if "!s:~%%P,1!" NEQ "" (
@			set /a "len+=%%P"
@			set "s=!s:~%%P!"
		)
	)
)
@(
@	endlocal
@	set "%~1=%len%"
@	exit /b
)