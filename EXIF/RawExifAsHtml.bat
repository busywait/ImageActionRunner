@echo ON

:: Creates a clever interactive hexidecimal (raw data) dump of image
:: EXIF data and saves it to a file with the same name as the (first)
:: image file given on the command line.
@set "runner_dir=%~dp0"
@call "%runner_dir%_callRunner.bat" -htmldump %1 > "%~n1.htm"
@exit /b
