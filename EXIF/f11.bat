:: This sets tags via exiftool command line options (stored in action_params), and without an Action .txt file
@set action_params=-FNumber=11 -FocalLength="200 mm"
@set runner_dir=%~dp0
@call "%runner_dir%_callRunner.bat" %*
