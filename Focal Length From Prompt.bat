@echo OFF

set "tag=FocalLength"
set "userPrompt=focal length in mm, or 0 for unknown"
call "%~dp0\Set From Prompt.bat" %*
