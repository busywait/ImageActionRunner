:: Form a command line based on the arguments passed and environment variables.

@set missing_environment=
@if [%runner_dir%]==[] ( set "mising_environment=runner_dir" )
@if NOT []==[%missing_environment%] goto :missingEnv

:: Only set the sidecar_mode if the calling script did not pass it in
@if []==[%sidecar_mode%] call :setSidecarMode $*

@if [%sidecar_mode%]==[ignore] (
	set runner="exiftool.exe" -@ "%runner_dir%_interactiveOptions.txt" 
	) else ( 
	set runner="exiftool.exe" -execute -if "-e $filepath" -srcfile "%%d%%f.xmp" -@ "%runner_dir%_sidecarFormats.txt" -common_args -@ "%runner_dir%_interactiveOptions.txt" )
@call :clearState
@exit /b

:setSidecarMode
:: If we've been passed a directory instead of a file list then exiftool will
:: process every writable file. No need to look for sidecar files in this case.
:: Otherwise use exiftool to act on related sidecar files as well as the base files.
@if EXIST "%~1\*" (
	set "sidecar_mode=ignore"
	) else ( 
	set "sidecar_mode=look" )
exit /b
	
:clearState
:: Allow running different scripts after each other in a command window
@set sidecar_mode=
@exit /b

:missingEnv
@call clearState
@echo Missing environment variables: %missing_environment%