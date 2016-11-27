@echo OFF

set /p fNumber="Enter the F-Number to tag this image with, 0 for unknown, or a blank line to do nothing and finish: "
if .%fNumber%==. goto :doNothing
::Let exiftool check that a valid number has been provided

set "runner_dir=%~dp0"
:: By default use exiftool to act on related sidecar files as well as the base files.
set "runner=_exiftoolPlusSidecar.bat"
:: If we've been passed a directory instead of a file list then exiftool will
:: process every supported file. No need to look for sidecar files in this case.
if EXIST "%~1\*" ( set "runner=_exiftool.bat" )

call "%runner_dir%%runner%" "%runner_dir%_commandPrompInputOptions.txt" -FNumber=%fNumber% %*
:: all done
exit /b

:doNothing
:: User chose to do nothing
@set /p a="No changes made. Press RETURN to close this window."
