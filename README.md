# ImageActionRunner

This is collection of scripts to allow useful command line utilities to be called from applications including the Windows File Explorer Send To menu, the ACDSee external editor, or the Adobe Elements Organizer. For example, image EXIF data can be updated to set or manipulate attributes like lens tags (focal length, F-Number and lens model), image time stamps, or GPS locations from within your favorite image organizer.

These scripts are intended to be configured and called as an external editor. Usually the only parameters sent to the editor are the file names to be edited. This purpose of this collection of scripts is to add the additional values needed to tag images, and simplify the effort and complexity of defining new actions. 

Most of the scripts here are wrappers for exiftool: http://www.sno.phy.queensu.ca/~phil/exiftool
The scripts integrate exiftool in to the graphical tools that you already use, they encapsulate the details of the exiftool usage for 
particular tasks, and apply exiftool in a consistent and convenient way. Exiftool.exe is included in the download package and you don't need to download anthing else to use these scripts. 

These scripts are for Windows computers (I assume 2000/XP/7/8/10, but I've only tested them on 10). Manual setup steps are required to configure these scripts 
before you can use them. 

## Setup and use

Download the latest version of ImageActionRunner as a zip from https://github.com/busywait/ImageActionRunner/archive/master.zip

Unzip the files to a suitable location, for example, c:\ImageActionRunner, or c:\utils\ImageActionRunner.

Configure your favourite image organizer to call the scripts as an external editor. If you image manager only allows a single external editor 
to be defined then choose the script "Run Exif Action.bat", which will list all actions currently in the Actions folder and allow you to type
the name of the one that you want to run. 

See the end of this file for tips for setting up Send To shortcuts for the Windows File Explorer context menu or ACDSee image manager.

## Application scripts

This is a list of the actions that are part of Exif Action Runner. They are described as command lines here, but you will not
need to type anything when you are using them from your image manager or Windows File Explorer.

### Read Metadata.bat

Usage: "Read Metadata.bat" (FILE [FILE...]|DIR)

Read metadata from image file FILE, or all files in directory DIR. If the file is a raw format file and has a sidecar .xmp file then any additional or duplicate metadata is read from that too and listed after the metadata from the base file.

### Run Exif Action.bat

Usage: "Run Exif Action.bat" (FILE [FILE...]|DIR)

List all of the action configurations (.txt files) in the folder Actions and prompt for an Action name to run. If a valid name is entered then the action will be run for each file FILE, or for each supported file in DIR. If the file is a raw format file and has a sidecar .xmp file then any additional or duplicate metadata is read from (or written to) the sidecar .xmp too.

### Focal Length From Prompt.bat

Usage: "Focal Length From Prompt.bat" (FILE [FILE...]|DIR)

Prompt a focal length value, eg 200, or 200 mm, but do not enter quote (") characters. The value will be written to each FILE, or for each supported writable file in DIR. If the file is a raw format file and has a sidecar .xmp file then the tag value is written to the sidecar .xmp too. 

Write 0 to indicate an unknown focal length.

### F-Number From Prompt.bat

Usage: "F-Number From Prompt.bat" (FILE [FILE...]|DIR)

Prompt for an F-number, eg 5.6 or 8. The value will be written to each FILE, or for each supported writable file in DIR. If the file is a raw format file and has a sidecar .xmp file then the tag value is written to the sidecar .xmp too. 

Write 0 to indicate an unknown F-number.

### Set From Prompt.bat

Usage: "Set From Prompt.bat" (FILE [FILE...]|DIR)

Prompt for an exiftool tag name and a value for the tag. The value will be written to each FILE, or for each supported writable file in DIR. If the file is a raw format file and has a sidecar .xmp file then the tag value is written to the sidecar .xmp too. 

### Time Add Offset From Prompt.bat

Usage: "Time Add Offset From Prompt.bat" (FILE [FILE...]|DIR)

Prompt for an offset in the format YY:mm:dd HH:MM:SS. The years, months, days, hours, minutes and seconds will be added to the DateTimeOriginal, CreateDate and ModifyDate. The value will be updated in each FILE, or for each supported writable file in DIR. If the file is a raw format file and has a sidecar .xmp file then the updated value is written to the sidecar .xmp too. 

If the HH:MM:SS part of the offset causes a time to cross midnight then the date will be updated to account for that. If a YY:mm:dd (date shift) part is supplied then the date is shifted before the time shift is applied.

Example offsets:
1 = 1 hour
0:90 = 90 minutes
0:0:120 = 120 seconds
1:2:3 4:5:6 = 1 year, 2 months, 3 days, 4 hours, 5 minutes and 6 seconds

(More detail about time shifts from the author of exiftool here: https://metacpan.org/pod/distribution/Image-ExifTool/lib/Image/ExifTool/Shift.pl) 

### Time Subtract Offset From Prompt.bat

See Time Subtract Offset from Prompt, above. Does the same but subtracts the offset.

### GPS Create GPX Track from Tagged Photos.bat

Usage: "GPS Create GPX Track from Tagged Photos.bat" (FILE [FILE...]|DIR)

Export GPS location tags from all selected images to a single file called track.gpx which will be created in the same folder as the first selected file, or in the selected folder. The GPX format is a standard format for recording GPS trails, and can be used for adding locations to images with no location tags.

### Export Raw EXIF to HTML.bat

Usage: "Export Raw EXIF to HTML.bat" (FILE [FILE...]|DIR)

Create an HTML file for each supported readable file in DIR that contains the binary EXIF data in hexadecimal with handy translation as you hover over the text.
Sidecar formats are ignored. Images without location tags will be ignored.

Files are named with the name of the original file with -exif.txt appended to the name.

## Tag sets and actions to be selected an run from Exif Action Runner.bat

EXIF tag sets can be defined in exiftool configuration filess which and contain tag name and values that you want to set together, or even other exiftool options that you would like to apply, for example reading metadata from a file. When you have defined a tag set then you can select one or more files in your image organizer and use the Exif Action Runner.bat application to chooes and apply the tag set.

See the EXIF tag set examples in the folder EXIF\Action Examples for ideas to get you started, and see all available options and details about the configuration file format (the -@ option) at the exiftool homepage:
http://www.sno.phy.queensu.ca/~phil/exiftool/.

Some exiftool options define actions that seem to be generally useful (other than writing tag values). Some actions like this are already present in the Actions folder. There are some examples of more specific actions in the Example Actions folder. You will probably want to copy and modify these examples to suit your own purposes.  

Any .txt file that you put in to the folder Actions will be listed and can be run from the Exif Action Runner.bat script.

###Creating actions for lenses or cameras

Exif Action Runner and saved actions are ideal for manually tagging images with details about the lens or camera used to take the picture. If you are going to create a large number of saved actions then it might be helpful to name the action files related to lenses with the prefix "Lens", for example "Lens Tamrom 500mm.txt". Similarly, actions for Camera should be prefixed with "Cam".

One helpful value to set is LensModel (valid for interchangable lenses, and for cameras with a fixed lens). By setting a consistent lens model value you will be able to search or navigate to images taken with that lens, and in some software you could automatically apply lens correction profiles for the lens. For consistency you should use the exact string that is given for your lens in the LensFun database:
http://lensfun.sourceforge.net/lenslist/
If your lens is not yet listed in the LensFun supported lens list try to use the same naming convention for "model":
http://lensfun.sourceforge.net/manual/el_lens.html

### -Delete Originals

This action deletes any exiftool backup file that might have been made for the files given in the command line, or all files in the given directories.

### -Restore Originals

If there is an exiftool backup files for the given file then this action deletes the current version of the file and restores the original file by renaming the backup.

## Wrapped actions

A wrapped action script is a script that runs a specific action .txt file from the Actions folder, and so is easy to call from Windows Send To or an image organizer application. Examples are "Read Metadata.bat", "f8.txt", and "f11-200mm.bat" which each demonstrate different ways to package an action to use via an external image organizer or Windows File Explorer Send To menu option.
	
You can configure these wrapped actions to be called as external editors in your image organizer, or add them as a Windows Send To shortcut. Copy and modify the existing wrapped action to suit your own purpose.

## Run actions on large sets of files

Because of the way that other applications pass the list of files to these scripts as a command line there is a limit on the number of files that can be passed at once. To get around this problem you can pass a directory name to the scripts and then all relevant files in the directory will be processed. You can pass a directory to the scripts by adding shortcuts to the scripts in the Windows Send To folder (described below). Then browse to the directory that you want to process and choose the script from the Send To context menu entry.
	
These scripts will show a warning and request permission to continue if it is likely that the list of files have been truncated.	
	
## Exiftool general configuration

The file _interactiveOptions.txt has the exiftool options that are used for every action that is run. If you become confident with the ability of exiftool and Image Action Runner/Exif Action Runner scripts to write valid files then you might want to uncomment the line that deletes your original image files after metadata has been written to them. The -Delete Originals and -Restore Originals actions both act on the backup files, so will have no effect if backups have not been written!

If you find that you have files with minor errors then exiftool will refuse to write more metadata in to the file - you could choose to override this by uncommenting the relevant line in _interactiveOptions.txt. Typically minor errors are introduced into camera maker notes by editing or organizer software writing new metadata to a file - Adobe Elements Organizer 15 has done this to some of my files, and I was happy to loose the maker notes for these file when I forced exiftool to write to the images. There is a little more detail in the exiftool FAQ: 
http://www.sno.phy.queensu.ca/~phil/exiftool/faq.html#Q15

The _sidecarFormats.txt file lists all of the image formats that are assumed to have .xmp sidecar files. If you find that you have raw files with an extension that is not in the list (but is supported by exiftool) then you could add it.

## Internal scripts

In general avoid editing the .bat scripts that are part of ImageActionRunner. When you are wrapping an action please note that scripts with names that start with _, for example "_callRunner.bat", are considered "internal", and more likely to change behavior than the main application scripts. 

## Seting up Windows Send To shortcuts

You can use these scripts from the Windows File Explorer Send To menu by creating shortcuts in %appdata%\Microsoft\Windows\Send To. Browse to the file "Run Exif Tool.bat" to select the Target for your Send To shortcut.

Leave the "Start in" field in the shortcut properties blank (although it should not matter what value you put there, leaving it 
blank might enable a carelessly written script to write any output files in your expected location).

For specific actions you can select any of the other .bat files in EXIF that do not start with an _ character. Create your own wrapped action to call in this 
way if needed. See the "Actions\f8.txt" or "Actions\Read Metadata.bat" files as examples, and don't forget to rename them before you start editing them!

### Avoid processing sidecar files

Some image editors allow changes to an image to be saved to a separate file instead of changing the original image file. These supporting files are called sidecar files. By default these scripts will search for sidecar files related to any file when updating tags using exiftool to ensure that metadata is updated
in all relevant places.

Because Windows Explorer will not hide related sidecar files in the way that most image managers will, you can select exactly the files that you want to process. You avoid sidecar searching by creating a Send To shortcut for a particular action .txt like this: 

Create a shortcut for a specific action .txt file by specifying stet.bat as the target with a parameter like
"C:\Users\sjmac\src\ImageActionRunner\EXIF\stet.bat" "Actions\-Restore Originals.txt"

You can also call stet.bat from a command line if you want to run a particular action .txt file.

## Example - setting up ACDSee to run these scripts as external editors 

You can integrate these scripts in to ACDSee menus and assign shortcut keys to run an action on selected files (in the Manage mode see Tools > External Editors > Configure Editors, and View > Toolbars > Customize). More detail for this configuration is given in the ACDSee documentation:
http://files.acdsystems.com/english/support/acdseepro/4/help/Content/1Topics/7_Options_configuration/Customizing_configuring/IDDH_CONFIG_EDITORS.htm
