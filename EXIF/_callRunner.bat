:: Form a command line based on the arguments passed and environment variables
:: run the command, and then clear down the state built during this run.

@set missing_environment=
@if [%runner_dir%]==[] ( set "mising_environment=runner_dir" )
@if [%action_params%]==[] ( set "mising_environment=runner_dir" )
@if NOT []==[%missing_environment%] goto :missingEnv

:: Only set the sidecar_mode if the calling script did not pass it in
@if []==[%sidecar_mode%] call :setSidecarMode $*

@if [%sidecar_mode%]==[ignore] (
	set runner=_exiftoolNoSidecarSearch.bat
	) else ( 
	set runner=_exiftoolLookForSidecars.bat
)
@call "%runner_dir%%runner%" %action_params% *
@call "%runner_dir%_clearRunState.bat"
@exit /b

:setSidecarMode
:: If we've been passed a directory instead of a file list then ask exiftool to
:: process every writable file. No need to look for sidecar files in this case.
:: Otherwise use exiftool to act on related sidecar files as well as the base files.
@if EXIST "%~1\*" (
	:: only process files passed directoy to exiftool
	set "sidecar_mode=ignore"
	) else ( 
	:: as well as processing the given file, look to see if there is a related sidecar
	set "sidecar_mode=look" )
::! .bat files only allow one comment line per code block (above) is .bat files !
@exit /b
	
:missingEnv
@call "%runner_dir%_clearRunState.bat"
@echo Missing environment variables: %missing_environment%