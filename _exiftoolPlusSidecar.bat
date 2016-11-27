:: A wrapper around exiftool that simplistically looks for .xmp sidecar files 
:: when acting on images with certain extensions (raw files) and processes 
:: both files when either reading or writing tag values.

:: Put exif tag values in Actions\<action>.txt and pass that as the first 
:: parameter before the list of files to be processed.

:: Usage _exiftoolPlusSidecar.bat OptionsFilename ImageFilename [ImageFilename...]
@echo OFF

set runner_dir=
set working_dir=
if 1==1 (
	:: exiftool config file paths can be relative, file paths must be absolute
	set "working_dir=%~dp0" 
) else (
	:: exiftool config paths must be absolute, file paths can be relative
	set "runner_dir=%~dp0" 
)
:: Don't put more than one comment line in a bracketed expressions, eg above!

pushd %working_dir%
@echo ON
exiftool.exe -execute -if "-e $filepath" -srcfile %%d%%f.xmp -@ "%runner_dir%_sidecarFormats.txt" -common_args -@ "%runner_dir%_interactiveOptions.txt" -@ %*
@echo OFF
popd
:: Rely on the -k exiftool option in _interactiveOptions.txt to keep the console open, 
:: or a prompt in the calling script.