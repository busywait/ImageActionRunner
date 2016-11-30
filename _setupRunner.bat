:: Form an appropriate command line for the arguments passed.

set missing_environment=
if [%runner_dir%]==[] ( set "mising_environment=runner_dir" )
if NOT []==[%missing_environment%] goto :missingEnv

:: If we've been passed a directory instead of a file list then exiftool will
:: process every writable file. No need to look for sidecar files in this case.
:: Otherwise use exiftool to act on related sidecar files as well as the base files.
if EXIST "%~1\*" (
	set runner="exiftool.exe" -@ "%runner_dir%_interactiveOptions.txt" 
	) else ( 
	set runner="exiftool.exe" -execute -if "-e $filepath" -srcfile "%%d%%f.xmp" -@ "%runner_dir%_sidecarFormats.txt" -common_args -@ "%runner_dir%_interactiveOptions.txt" )
exit /b

:missingEnv
echo Missing environment variables: %missing_environment%