:: Responsibilities of _callRunner.bat:
:: 1/ Check the command line for problems <- this should be in Exif Action Runner?
:: 2/ Ensure environment variables are set appropriately
:: 3/ Call the runner, _exiftool.bat
:: 4/ Clear down state after running

:: CHECK THE COMMAND LINE

:: These scripts expect to receive all file and directory names to be processed
:: on a command line because that makes it possible to integrate these scripts
:: with image organizers and the Windows Send To menu. 


@call :cmdlen cmdLength
@echo %cmdcmdline%
@echo Command Length: %cmdLength%
@set "run_choice=file_list"
:: There are 
:: limits on the length that a command line can be. Commands launched from 
:: ACDSee Pro/Ultimate 10 are seen to truncate external editor commands at 
:: around (but not exactly, and sometimes more than) 2047 characters. File names 
:: always seem to be intact, and don't finish half way through.

:: The Windows File Explorer Send To feature in Windows 10 does not truncate at 
:: 2047 characters, but .cmd scripts like Exif Action Runner will not run if the 
:: number of files selected forms a command line over 8192(?) characters.

:: If we have got this far then the script is running so we have not hit the 8192 
:: character limit. If the command line length is over 3000 characters then it is 
:: unlickely to be from ACDSee. Between 2000 and 3000 we warn that the command is 
:: at risk of having been truncated

:: ACDSee image organizer does not allow folders to be passed to this script, so it is 
:: useful to allow the user to process the parent folder if the list of individual files 
:: is too long. There is no check that all file selections are in the same folder, we 
:: just use the parent of the first selection.
@if %cmdLength% geq 2000 ( 
	if %cmdLength% leq 3000 (
		setlocal EnableDelayedExpansion
		echo WARNING: It looks like the list of files to process might have been truncated. 
		echo Review the command above - you will need to process any remaining files seperately. 
		echo Also consider putting all of the files in the same directory and running your action 
		echo on the directory, or using an action shortcut in the Windows File Explorer Send To 
		echo which supports a longer file list and running actions on folders. 
		set /p response="Press return to continue, enter q stop and choose a smaller set of files, or f to run the action on all files in folder %~dp1 : "

		if "q"=="!response!" (
			endlocal
			goto :cleanupAndFinish
		)
		if "f"=="!response!" (
			endlocal
			goto :processWholeFolderInsteadOfFileSelection
		)
		endlocal
	)
)	

:: Do not override sidecar_mode if the calling script specified it
@if NOT DEFINED sidecar_mode call :setSidecarMode %*
@if [%run_choice%]==[file_list] (
	call "%runner_dir%_exiftool.bat" %action_params% %*
) else (
	if [%run_choice%]==[parent_folder] (
		call :processWholeFolderInsteadOfFileSelection
	)
)

:cleanUpAndFinish
@call "%runner_dir%_clearRunState.bat"
@exit /b

:processWholeFolderInsteadOfFileSelection
@if EXIST "%~1\*" (
	echo "The first item in your list is a folder, %~1."
	echo "Processing the parent folder of a list of folders is not supported."
) else ( 
	set "sidecar_mode=ignore"
	call "%runner_dir%_exiftool.bat" %action_params% "%~dp1."
)
:: Append . at the end of %~dp1. (above) because exiftool fails to process a folder path if it ends in \
:: 
:: .bat files only allow one comment line per code block (above) !
goto :cleanUpAndFinish

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