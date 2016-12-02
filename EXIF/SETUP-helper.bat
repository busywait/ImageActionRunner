:: You can use these scripts as "External Editors" in various image 
:: organizers like Adobe Elements Organizer or ACDSee.

:: These scripts require exiftool to run. You can download it from 
:: http://www.sno.phy.queensu.ca/~phil/exiftool/

@echo If you do not want to use the version of exiftool bundled here then you need to 
@echo add your own installed version of exiftool.exe to your path.
::set exiftoolPath=%~dp0/EXIF
:: Add exiftool to your user PATH (it is safe to run this multiple times on Windows 10)
::setx PATH "%PATH%;%exiftoolPath%"
::@echo Your path has been updated to include %exiftoolPath%

:: exiftool is called exiftool(-k).exe by default. If it hasn't been renamed 
:: already then create a link called "exiftool.exe" to "exiftool(-k).exe"
::mklink /H "%exifToolPath%\exiftool(-k).exe" "%exifToolPath%\exiftool.exe"

:: Create Windows Send To shortcuts for the most interesting options
:: There isn't a direct way to do this from a .bat file.
@echo "You can create your own Send To shortcuts for File Explorer..."
explorer "%appdata%\Microsoft\Windows\SendTo"

:: Find a way to add ACDSee actions?

:: All done
@set /p a=Press RETURN to close this Window.