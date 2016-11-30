:: Run exiftool in a wrapper with some common options.
:: This is called from the Windows "Write ..." Send To shortcuts. It does not try to be 
:: smart and update related files, and all required files must be selected by the user.

:: Usage _exiftool.bat exiftoolOptionsFile (ImageFilename [ImageFilename...]| DIR)

:: Contract: 
:: - exiftool configuration can be absolute or relative to the script dir
:: - input image files must be given an absolute path

:: Usage _exiftool.bat ActionFilename (DIR|ImageFilename [ImageFilename...])
@echo OFF

set "working_dir=%~dp0" 
pushd %working_dir%
echo ON
exiftool.exe -@ "_interactiveOptions.txt" -@ %*
@echo OFF
popd
:: Rely on the -k exiftool option in _interactiveOptions.txt to keep the console open, 
:: or a prompt in the calling script.