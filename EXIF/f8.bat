:: This runs the action described in the file Action\f8.txt
@set "action=f8"
@set %runner_dir%=%~dp0
@call "%runner_dir%Exif Action Runner.bat" %*
