:: A wrapper around exiftool that simplistically looks for .xmp sidecar files 
:: when acting on images with certain extensions (raw files) and processes 
:: both files when either reading or writing tag values.

:: Put exif tag values in Actions\<action>.txt and pass that as the first 
:: parameter before the list of files to be processed.

:: Contract: 
:: - exiftool configuration can be absolute or relative to the script dir
:: - input image files must be given an absolute path

:: Usage _exiftool.bat ActionFilename (DIR|ImageFilename [ImageFilename...])
@echo OFF

set "working_dir=%~dp0" 
pushd %working_dir%
@echo ON
exiftool.exe -execute -if "-e $filepath" -srcfile %%d%%f.xmp -@ "%runner_dir%_sidecarFormats.txt" -common_args -@ "%runner_dir%_interactiveOptions.txt" -@ %*
@echo OFF
popd
:: Rely on the -k exiftool option in _interactiveOptions.txt to keep the console open, 
:: or a prompt in the calling script.