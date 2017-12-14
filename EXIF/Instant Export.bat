@echo ON

:: Instant Export: write copies of the best jpg preview image found for each 
:: of the selected files, and then copies metadata from the selected files in 
:: to the generated preview.

@set "runner_dir=%~dp0"
@set "sidecar_mode=ignore"
@set "extra_common_args=--ext .jpg"
@set "copy_mode=copy"
:: TODO: instead of only excluding .jpg, only include raw files? -@ _sidecarFormats.txt
@set "action_params=-@ %runner_dir%_export_best_embedded_preview.txt"
@call "%runner_dir%_callRunner.bat" %*
@exit /b

