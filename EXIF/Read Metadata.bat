:: Run exiftool in a wrapper that can be used as an external editor in ACDSee.
:: Read metadata as a cross check after writing, and compare to metadata 
:: shown in the UI.
@echo ON
@mode 190,1000

@set "runner_dir=%~dp0"
:: Read metadata from the selected file, and any related sidecar .xmp file
@call %runner_dir%_setupRunner.bat $*
call %runner% -@ "%runner_dir%Actions\Read Metadata.txt" %*
