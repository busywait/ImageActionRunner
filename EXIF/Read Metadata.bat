:: Run exiftool in a wrapper that can be used as an external editor in ACDSee.
@echo ON
@mode 190,1000
:: This runs the action described in the file Actions\Read Metadata.txt
@set "action=Read Metadata"
@set runner_dir=%~dp0
:: Read metadata from the selected file, and any related sidecar .xmp file
@call "%runner_dir%Exif Action Runner.bat" %*
