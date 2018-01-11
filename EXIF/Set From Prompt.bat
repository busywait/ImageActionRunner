@echo ON

@if NOT DEFINED tag (
	:: set statements don't work in an if block, so call them
	call :setTagFromUserInput
)
:: Caution: clear the state (tag and value) that has been set here to allow 
:: repeated calls from an interactive command prompt.

:: Wrapper scripts can pass in a tag and value to run non-interactively (wrapped input)
@if DEFINED value goto :buildParamsAndRunAction

@set /p value="Enter the %userPrompt%, or a blank line to do nothing and finish: "
@if NOT DEFINED value goto :doNothing
::Let exiftool check that a valid value has been provided

::assignType can be '+', '-', or '' (blank) for append, remove, or over-write.
::assignType must be passed in if needed.

:buildParamsAndRunAction
@set "runner_dir=%~dp0"
@set action_params=-%tag%%assignType%="%value%"

@if DEFINED tag2 (
	call :setTagAliasValue %tag2%
)
@if DEFINED tag3 (
	call :setTagAliasValue %tag3%
)
@if DEFINED tag4 (
	call :setTagAliasValue %tag4%
)
@if DEFINED tag5 (
	call :setTagAliasValue %tag5%
)

@call "%runner_dir%_callRunner.bat" %*
@exit /b

:setTagFromUserInput
@	set /p tag="Enter the name of the tag to write:"
@	set "userPrompt=value for tag %tag%"
@exit /b

:setTagAliasValue <tagAlias>
@set action_params=%action_params% -%1%assignType%="%value%"
@exit /b

:doNothing
:: User chose to do nothing
@set /p a="No changes made. Press RETURN to close this window."
@call %runner_dir%_clearRunState.bat
@exit /b
