::@ cd /d %~dp0
set "runner_dir=%~dp0"
"%runner_dir%_exiftoolPlusSidecar.bat" "%runner_dir%Actions\f2.5.txt" %*
