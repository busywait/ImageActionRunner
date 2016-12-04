# ImageActionRunner

A collection of scripts to allow image EXIF data to be updated from the Windows File Explorer Send To menu, as an ACDSee external editor, or the Adobe Elements Organizer external editor.

Often image organizers allow an image to be sent to an external editor. Usually the only parameters sent to the editor are the file names to be edited. This collection of scripts makes it easy to store and use sets of values to tag images with information, for example about the lens used to take a photograph, lens focal length, or F-number.

## Setup and use

Download the latest version of ImageActionRunner as a zip from https://github.com/busywait/ImageActionRunner/archive/master.zip

Unzip the files to a suitable location, for example, c:\ImageActionRunner, or c:\utils\ImageActionRunner.

Configure your favourite image organizer to call the scripts as an external editor. If you would like to use these scripts from the Windows File Explorer Send To menu then you can create shortcuts in %appdata%\Microsoft\Windows\Send To. The "Send To Exiftool.bat" script can be used as the shortcut target if you want to run a specific action without any prompts, for example, 
    "c:\ImageActionRunner\EXIF\Send To Exiftool.bat" "Actions\f8.txt" 

### Example - ACDSee External Editor configuration
Write me.

## Application scripts

### Read Metadata.bat

Usage: "Read Metadata.bat" (FILE [FILE...]|DIR)

Read metadata from image file FILE, or all files in directory DIR. If the file is a raw format file and has a sidecar .xmp file then any additional or duplicate metadata is read from that too.

### Run Exif Action.bat

Usage: "Run Exif Action.bat" (FILE [FILE...]|DIR)

List all action configurations (.txt files) in the folder Actions and prompt for an Action name. If a valid name is entered then the action will be run for each file FILE, or for each file in DIR. If the file is a raw format file and has a sidecar .xmp file then any additional or duplicate metadata is read from that too.

### Set From Prompt.bat

Usage: "Set From Prompt.bat" (FILE [FILE...]|DIR)

Prompt for an exiftool tag name and a value for the tag. The value will be written to each FILE, or for each file in DIR. If the file is a raw format file and has a sidecar .xmp file then any additional or duplicate metadata is read from that too. 

### Focal Length From Prompt.bat

Write me.

### F-Number From Prompt.bat

Write me.

## Actions

EXIF Actions are formatted as exiftool configuration files. See available options and details about the configuration file format (-@ option) at the exiftool homepage:
http://www.sno.phy.queensu.ca/~phil/exiftool/

See the examples in the folder EXIF\Action Examples.

Some actions that seem to be generally useful are already present in the Actions folder, and you will probably want to copy or modify these and the actions in the folder Action Examples to suit your own purposes. 

Any .txt file that you put in to the folder Actions will be listed and can be run from the Exif Action Runner.bat script.

### -Delete Originals

This action deletes any original file backup that exiftool might have made for the given files or all files in the given directories.

### -Restore Originals

If there is an original file backup for the given file then this action deletes the current version of the file and restores the original file by renaming the backup.

## Wrapped actions

A wrapped action script is a script that runs a specific action .txt file from the Actions folder, and so is easy to call from Windows Send To or an image organizer application. An example is 
    Actions\f8.txt
	
You can configure these wrapped actions to be called as external editors in your image organizer, or add them as a Windows Send To shortcut. Copy and modify the existing wrapped action to suit your own purpose.
	
## Additional configuration

In general avoid editing the .bat scripts that are part of ImageActionRunner. The file \_interactiveOptions.txt has the common exiftool options that are used for every action that is run. If you become confident in the metadata written then you might want to uncomment the line that deletes your original image files after metadata has been written to them.

## Internal scripts

Write me.
