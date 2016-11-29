@if "%tag%"=="" (
	:: set statements don't work in an if block!
	call :setTagFromUserInput
)
:: Caution: clear tag and value as set here to allow repeated calls from an interactive command prommpt.

@set /p value="Enter the %userPrompt%, or a blank line to do nothing and finish: "
@if "%value%"=="" goto :doNothing
::Let exiftool check that a valid value has been provided

@set "runner_dir=%~dp0"
:: By default use exiftool to act on related sidecar files as well as the base files.
@set "runner=_exiftoolPlusSidecar.bat"
:: If we've been passed a directory instead of a file list then exiftool will
:: process every supported file. No need to look for sidecar files in this case.
@if EXIST "%~1\*" ( set "runner=_exiftool.bat" )

call "%runner_dir%%runner%" "%runner_dir%_commandPrompInputOptions.txt" -%tag%="%value%" %*
call :unsetUserInput
:: all done
@exit /b

:setTagFromUserInput
	set /p tag="Enter the name of the tag to write:"
	set "userPrompt=value for tag %tag%"
exit /b

:unsetUserInput
	:: clean up the environment for next time in case this is run from 
	:: a user typing in to a command prompt
	set tag=
	set value=
exit /b

:doNothing
:: User chose to do nothing
@set /p a="No changes made. Press RETURN to close this window."
@call :unsetUserInput
@exit /b
