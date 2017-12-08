@echo ON

:: Instant Export: write copies of the best jpg preview image found for each 
:: of the selected files, and then copies metadata from the selected files in 
:: to the generated preview.

@set "runner_dir=%~dp0"
:: No output redirection needed
::@set "outfile=%~dpn1-previews.txt"
@set "sidecar_mode=ignore"
:: TODO: only consider raw files? -@ _sidecarFormats.txt
@set "extra_common_args=--ext .jpg"
:: TODO: also look for editor/developer/organizer preview images, eg in the hidden ACDSee [Developed] folder
@set "action_params=-@ %runner_dir%_export_best_embedded_preview.txt"
@call "%runner_dir%_callRunner.bat" %*
@exit /b

