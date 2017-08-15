@echo ON

:: Creates a clever interactive hexidecimal (raw data) dump of image
:: EXIF data and saves it to a file with the same name as each
:: image file given on the command line (or each file in the folder).

@set "runner_dir=%~dp0"
:: Don't use output redirection, the -w parameter works better for this case because it 
:: creates an output file for each input file instead of joining all output together.
::@set "outfile=%~dpn1-exif.htm"
@set "sidecar_mode=ignore"
@set "action_params=-@ %runner_dir%_htmldump.txt"
@call "%runner_dir%_callRunner.bat" %*
@exit /b

