@echo ON

@if "%tag%"=="" (
	:: set statements don't work in an if block, so call them
	call :setTagFromUserInput
)
:: Caution: clear the state (tag and value) that has been set here to allow 
:: repeated calls from an interactive command prompt.

@set /p value="Enter the %userPrompt%, or a blank line to do nothing and finish: "
@if "%value%"=="" goto :doNothing
::Let exiftool check that a valid value has been provided

@set "runner_dir=%~dp0"
@set action_params=-%tag%="%value%"
@call "%runner_dir%_callRunner.bat" %*
@exit /b

:setTagFromUserInput
@	set /p tag="Enter the name of the tag to write:"
@	set "userPrompt=value for tag %tag%"
@exit /b

:doNothing
:: User chose to do nothing
@set /p a="No changes made. Press RETURN to close this window."
@call :unsetUserInput
@exit /b
