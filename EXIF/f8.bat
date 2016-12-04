:: This sets tags via exiftool command line options (stored in action_params), and without an Action .txt file
@set action_params=-FNumber="8"
@set %runner_dir%=%~dp0
@call "%runner_dir%Exif Action Runner.bat" %*
