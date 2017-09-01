@echo ON

:: For any file that has a GPS location tag, 
:: put a point in to a KML track file
:: order the points by DateTimeOrignal
:: all DateTimeOriginal times must be in the same timezone.

:: GPS times are in UTC, and timestamps in photos are assumed to be in the PC localtime for this 
:: Conversion unless the created times have an offset included.
@set "runner_dir=%~dp0"
@set "gps_track_format=kml"
@call "%runner_dir%_gpsCreateTrack.bat" %*
@exit /b

