:: Batch file to use as a Send To shortcut in Windows File Explorer or 
:: as an external editor in an image manager application.

:: Responsibilities of Exif Action Runner.bat
:: -/ Check command line for problems? Currently done in _call_runner.bat
:: 1/ List appropriate Actions
:: 2/ Allow user to select an action to run
:: 3/ Hold UI open to see results
@echo ON

@if "%~1" == "" goto:showUsageAndFinish
@set "runner_dir=%~dp0"

:: Wrapper scripts can pass in an action name
@if DEFINED action goto :buildParamsAndRunAction

:: List available actions
@echo Available EXIF actions in %runner_dir%Actions:
@echo ========================
:: List the .txt files from sub-folder "Actions" (filename only, no extension)
@for %%f in ("%runner_dir%Actions\*.txt") do @echo %%~nf
@echo ========================
@echo Which action do you want to run?
@echo. 
@set /p action="Type a name from the list above and press Return, or press Return to do nothing and finish: "

@if NOT DEFINED action goto:doNothing

:: TODO: ask again if an action that does not exist is specified

:buildParamsAndRunAction
@set action_params=-@ "%runner_dir%Actions\%action%.txt"
@call "%runner_dir%_callRunner.bat" %*
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
@call %runner_dir%_clearRunState.bat
@set /p a="Press RETURN to close this window."