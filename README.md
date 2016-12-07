# ImageActionRunner

A collection of scripts to allow image EXIF data to be updated from the Windows File Explorer Send To menu, as an ACDSee external editor, or the Adobe Elements Organizer external editor.

Often image organizers allow an image to be sent to an external editor. Usually the only parameters sent to the editor are the file names to be edited. This collection of scripts makes it easy to store and use sets of values to tag images with information, for example about the lens used to take a photograph, lens focal length, or F-number.

## Setup and use

Download the latest version of ImageActionRunner as a zip from https://github.com/busywait/ImageActionRunner/archive/master.zip

Unzip the files to a suitable location, for example, c:\ImageActionRunner, or c:\utils\ImageActionRunner.

Configure your favourite image organizer to call the scripts as an external editor. You can use these scripts from the Windows File Explorer Send To menu by creating shortcuts in %appdata%\Microsoft\Windows\Send To. 

### Example - ACDSee External Editor configuration

You can integrate these scripts in to ACDSee menus and assign shortcut keys to run an action on selected files (in the Manage mode see Tools > External Editors > Configure Editors, and View > Toolbars > Customize). More detail for this configuration is given in the ACDSee documentation:
http://files.acdsystems.com/english/support/acdseepro/4/help/Content/1Topics/7_Options_configuration/Customizing_configuring/IDDH_CONFIG_EDITORS.htm

## Application scripts

### Read Metadata.bat

Usage: "Read Metadata.bat" (FILE [FILE...]|DIR)

Read metadata from image file FILE, or all files in directory DIR. If the file is a raw format file and has a sidecar .xmp file then any additional or duplicate metadata is read from that too and listed after the metadata from the base file.

### Run Exif Action.bat

Usage: "Run Exif Action.bat" (FILE [FILE...]|DIR)

List all action configurations (.txt files) in the folder Actions and prompt for an Action name to run. If a valid name is entered then the action will be run for each file FILE, or for each supported file in DIR. If the file is a raw format file and has a sidecar .xmp file then any additional or duplicate metadata is read from (or written to) the sidecar .xmp too.

### Set From Prompt.bat

Usage: "Set From Prompt.bat" (FILE [FILE...]|DIR)

Prompt for an exiftool tag name and a value for the tag. The value will be written to each FILE, or for each supported writable file in DIR. If the file is a raw format file and has a sidecar .xmp file then the tag value is written to the sidecar .xmp too. 

### Focal Length From Prompt.bat

Usage: "Focal Length From Prompt.bat" (FILE [FILE...]|DIR)

Prompt a focal length value, eg 200, or 200 mm, but do not enter quote (") characters. The value will be written to each FILE, or for each supported writable file in DIR. If the file is a raw format file and has a sidecar .xmp file then the tag value is written to the sidecar .xmp too. 

Write 0 to indicate an unknown focal length.

### F-Number From Prompt.bat

Usage: "F-Number From Prompt.bat" (FILE [FILE...]|DIR)

Prompt for an F-number, eg 5.6 or 8. The value will be written to each FILE, or for each supported writable file in DIR. If the file is a raw format file and has a sidecar .xmp file then the tag value is written to the sidecar .xmp too. 

Write 0 to indicate an unknown F-number.

## Actions

EXIF Actions are formatted as exiftool configuration files and contain tag name and values that you want to set together, or even other exiftool options that you would like to apply, for example reading metadata from a file. When you have defined an action then you can select one or more files in your image organizer and use the Exif Action Runner.bat application to chooes and apply the action.

See the EXIF Action examples in the folder EXIF\Action Examples for ideas to get you started, and see all available options and details about the configuration file format (the -@ option) at the exiftool homepage:
http://www.sno.phy.queensu.ca/~phil/exiftool/.

Some actions that seem to be generally useful are already present in the Actions folder. There are some examples of more specific actions in the Example Actions folder. You will probably want to copy and modify these examples to suit your own purposes.  

Any .txt file that you put in to the folder Actions will be listed and can be run from the Exif Action Runner.bat script.

###Creating actions for lenses or cameras

Exif Action Runner and saved actions are ideal for manually tagging images with details about the lens or camera used to take the picture. If you are going to create a large number of saved actions then it might be helpful to name the action files related to lenses with the prefix "Lens", for example "Lens Tamrom 500mm.txt". Similarly, actions for Camera should be prefixed with "Cam".

One helpful value to set is LensModel (valid for interchangable lenses, and for cameras with a fixed lens). By setting a consistent lens model value you will be able to search or navigate to images taken with that lens, and in some software you could automatically apply lens correction profiles for the lens. For consistency you should use the exact string that is given for your lens in the LensFun database:
http://lensfun.sourceforge.net/lenslist/
If your lens is not yet listed in the LensFun supported lens list try to use the same naming convention for "model":
http://lensfun.sourceforge.net/manual/el_lens.html

### -Delete Originals

This action deletes any original file backup that exiftool might have made for the given files or all files in the given directories.

### -Restore Originals

If there is an original file backup for the given file then this action deletes the current version of the file and restores the original file by renaming the backup.

## Wrapped actions

A wrapped action script is a script that runs a specific action .txt file from the Actions folder, and so is easy to call from Windows Send To or an image organizer application. Examples are "Read Metadata.bat", "f8.txt", and "f11.bat" which each demonstrate different ways to package an action to use via an external image organizer or Windows File Explorer Send To menu option.
	
You can configure these wrapped actions to be called as external editors in your image organizer, or add them as a Windows Send To shortcut. Copy and modify the existing wrapped action to suit your own purpose.

## Run actions on large sets of files

Because of the way that other applications pass the list of files to these scripts there is a limit on the number of files that can be passed at one time. To get around this problem you can pass a directory name to the scripts and then all relevant files in the directory will be processed. You can pass a directory to the scripts by adding shortcuts to the scripts in the Windows Send To folder (described above). Then browse to the directory that you want to process and choose the script from the Send To context menu entry.
	
These scripts will show a warning and request permission to continue if it is likely that the list of files have been truncated.	
	
## Additional configuration

The file _interactiveOptions.txt has the exiftool options that are used for every action that is run. If you become confident with the ability of exiftool and Image Action Runner/Exif Action Runner scripts to write valid files then you might want to uncomment the line that deletes your original image files after metadata has been written to them. The -Delete Originals and -Restore Originals actions both act on the backup files, so will have no effect when backups have not been written!

If you find that you have files with minor errors then exiftool will refuse to write more metadata in to the file - you could choose to override this by uncommenting the relevant line in _interactiveOptions.txt. Typically minor errors are introduced into camera maker notes by editing or organizer software writing new metadata to a file - Adobe Elements Organizer 15 has done this to some of my files, and I was happy to loose the maker notes for these file when I forced exiftool to write to the images. There is a little more detail in the exiftool FAQ: 
http://www.sno.phy.queensu.ca/~phil/exiftool/faq.html#Q15

The _sidecarFormats.txt file lists all of the image formats that are assumed to have .xmp sidecar files. If you find that you have raw files with an extension that is not in the list (but is supported by exiftool) then you could add it.

## Internal scripts

In general avoid editing the .bat scripts that are part of ImageActionRunner. When you are wrapping an action please note that scripts with names that start with _, for example "_callRunner.bat", are considered "internal", and more likely to change behaviour than the main application scripts. 
