@echo ON

:: For any file that has a GPS location tag, 
:: put a point in to a GPX track file
:: order the points by DateTimeOrignal
:: all DateTimeOriginal times must be in the same timezone.

@set "runner_dir=%~dp0"
@set "outfile=%~dp1track.gpx"
:: Options are mostly in the _gps_gpx.txt argfile to avoid crazy % encoding
::-if "$gpslongitude ge 0" -fileOrder DateTimeOriginal -d %%%%%%%%Y-%%%%%%%%m-%%%%%%%%dT%%%%%%%%H:%%%%%%%%M:%%%%%%%%SZ 
::-p option kept on the command line here because I can't expand the full path for the print format file _gps_gpx.fmt in config
@set "action_params=-p "%runner_dir%_gps_gpx.fmt" -@ %runner_dir%_gps_gpx.txt"
:: .xmp files are scanned in a second pass which will write GPS files out of sequence, so ignore sidecars here
@set "sidecar_mode=ignore"
@call "%runner_dir%_callRunner.bat" %*
@exit /b

