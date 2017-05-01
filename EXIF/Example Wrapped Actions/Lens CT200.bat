:: Run exiftool in a wrapper that can be used as an external editor in ACDSee.
@echo ON
@mode 190,1000
@set "action=Lens CT200"
@set runner_dir=%~dp0
@call "%runner_dir%Exif Action Runner.bat" %*
