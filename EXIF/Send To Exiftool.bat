:: A wrapper to run exiftool with some common options, and
:: do not try to find .xmp sidecar files for raw files.
:: This was written to be called from the Windows Send To menu.
:: Usage: $0 ACTION (FILE [FILE...]|DIR)
:: ACTION must be an absolute path.

:: Usage _exiftool.bat ActionFilename (DIR|ImageFilename [ImageFilename...])
@echo ON

@set "working_dir=%~dp0" 
@pushd %working_dir%
exiftool.exe -@ "_interactiveOptions.txt" -@ %*
@popd
:: Rely on the -k exiftool option in _interactiveOptions.txt to keep the console open