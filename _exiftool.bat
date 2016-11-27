:: Run exiftool in a wrapper with some common options.
:: This is called from the Windows "Write ..." Send To shortcuts. It does not try to be 
:: smart and update related files, and all required files must be selected by the user.

:: Usage _exiftool.bat exiftoolOptionsFile (ImageFilename [ImageFilename...]| DIR)

:: Contract: 
:: - exiftool configuration files are relative to the script dir
:: - input image files must be given an absolute path

:: Usage _exiftool.bat OptionsFilename ImageFilename [ImageFilename...]
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
echo ON
exiftool.exe -@ "%runner_dir%_interactiveOptions.txt" -@ %*
@echo OFF
popd
:: Rely on the -k exiftool option in _interactiveOptions.txt to keep the console open, 
:: or a prompt in the calling script.