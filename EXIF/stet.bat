:: stet = Send To ExifTool
:: stet.bat is useful for Windows Send To shortcuts, or to call from the command line.

:: This is a wrapper to run exiftool with some common options, but without searching 
:: for .xmp sidecar files for raw file formats. The action .txt file is specified on 
:: the command line to avoid having to create a .bat action wrapper. The purpose of 
:: this file is to avoid exposing internal files for this!

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