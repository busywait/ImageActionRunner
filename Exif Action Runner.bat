:: Batch file to use as a Send To shortcut in Windows File Explorer or 
:: as an external editor in an image manager application.
@echo ON

@if "%~1" == "" goto:showUsageAndFinish

@set "runner_dir=%~dp0"

:: List available actions
@echo Available EXIF actions in %runner_dir%Actions:
@echo ========================
:: List the .txt files from sub-folder "Actions" (filename only, no extension)
@for %%f in ("%runner_dir%Actions\*.txt") do @echo %%~nf
@echo ========================
@echo Which action do you want to run?
@echo. 
@set /p action="Type a name from the list above and press Return, or press Return to do nothing and finish: "

@if "%action%"=="" goto:doNothing

@call %runner_dir%_setupRunner.bat %*
@call %runner% -@ "%runner_dir%Actions\%action%.txt" %*
@exit /b

:showUsageAndFinish
@echo $0 is intended for calling as a Send To shortcut in File Explorer, or 
@echo as an external editor in an image organizer like ACDSee or Elements Organizer.
@echo USAGE: $0 ACTION (FILE [FILE...]|DIR)
@echo.
:: drop through
:doNothing
@echo Nothing was done.
:: drop through
:finished
@set /p a="Press RETURN to close this window."