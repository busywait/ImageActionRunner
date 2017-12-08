@echo ON

:: For any file that has a GPS location tag, 
:: put a point in to a GPX track file
:: order the points by DateTimeOrignal
:: all DateTimeOriginal times must be in the same timezone.

:: GPS times are in UTC, and timestamps in photos are assumed to be in the PC localtime for this 
:: Conversion unless the created times have an offset included.

@set "runner_dir=%~dp0"
:: If the first selection is a file put the track in to the parent folder, 
:: otherwise if the first selection is a folder put the track in to that folder.
@if EXIST "%~1\*" (
	set "folder=%~1\"
	) else ( 
	set "folder=%~dp1"
)
@set "outfile=%folder%track.%gps_track_format%"
:: Options are mostly in the _gps_create_track.txt argfile to avoid crazy % encoding, like this
::-if "$gpslongitude ge 0" -fileOrder DateTimeOriginal -d %%%%%%%%Y-%%%%%%%%m-%%%%%%%%dT%%%%%%%%H:%%%%%%%%M:%%%%%%%%SZ 

::-p option is added to the command line here to allow format selection at run time (to share code):
@set "action_params=-p "%runner_dir%_gps_%gps_track_format%.fmt" -@ %runner_dir%_gps_create_track.txt"
:: .xmp files are scanned in a second pass which will write GPS files out of sequence, so ignore sidecars here
@set "sidecar_mode=ignore"

@call "%runner_dir%_callRunner.bat" %*
@exit /b

