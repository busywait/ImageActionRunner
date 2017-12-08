@echo ON

:: Writes copies of *all* preview images found in the selected files.
::

@set "runner_dir=%~dp0"
:: No output redirection needed
::@set "outfile=%~dpn1-previews.txt"
::@set "sidecar_mode=ignore"
@set "action_params=-@ %runner_dir%/Actions/Export Embedded Images.txt"
@call "%runner_dir%_callRunner.bat" %*
@exit /b
