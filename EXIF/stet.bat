:: A wrapper to run exiftool with some common options, and
:: do not try to find .xmp sidecar files for raw files.

:: This script does not search for sidecar files because Windows File Explorer
:: gives you the chance to select the .xmp files if you want to process them 
:: (recommended that you do if they exist), and it avoids double processing 
:: .xmp files if all of the files in a directory are processed.

:: Usage stet.bat ActionFilename (DIR|ImageFilename [ImageFilename...])
:: ACTION can be relative to the install folder (eg, Actions\f8.txt), image file
:: paths must be absolute.
@echo ON

@set runner_dir=%~dp0
@pushd %runner_dir%
@call _exiftoolNoSidecarSearch.bat -@ %*
@popd
:: Rely on the -k exiftool option in _interactiveOptions.txt to keep the console open