:: This is a set of exiftool configurations and Windows command files that 
:: make it easy to use to view, add and remove metadata in camera image files.

:: Options to add lens data and f/number for manual lenses are added to the 
:: Windows File Explorer "Send To" context menu. Select the files that you
:: want to update, right click, choose Send To, and choose one of the EXIF 
:: options that this script has added.

:: You can also use these scripts as "External Editors" in various image 
:: organizers like Adobe Elements Organizer or ACDSee.

:: These scripts require exiftool to run. You can download it from 
:: http://www.sno.phy.queensu.ca/~phil/exiftool/

:: YOU NEED TO CHANGE THIS
:: Give the folder name that you unpacked your exiftool in to
set exiftoolPath=c:\utils\exiftool

:: DON'T CHANGE ANYTHING ELSE :)
:: Now run this script by double clicking it, or running it from the command 
:: line.

:: Make sure the working directory is the folder that this script is saved in
pushd %~dp0

:: exiftool is called exiftool(-k).exe by default. If it hasn't been renamed 
:: already then create a link called "exiftool.exe" to "exiftool(-k).exe"
mklink /H "%exifToolPath%\exiftool(-k).exe" "%exifToolPath%\exiftool.exe"

:: Add exiftool to your user PATH (it is safe to run this multiple times on Windows 10)
setx PATH "%PATH%;%exiftoolPath%"
@echo Your path has been updated to include %exiftoolPath%

:: Create Windows Send To shortcuts for the most interesting options
:: There isn't a direct way to do this from a .bat file.
@echo "You can create your own Send To shortcuts for File Explorer..."
explorer "%appdata%\Microsoft\Windows\SendTo"

:: Restore the working directory that we started in
popd
 
:: All done
::@echo "Windows File Explorer shortcuts have been created."
@set /p a=Press RETURN to close this Window.