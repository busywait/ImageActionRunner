:: Responsibilities of _exiftool.bat

:: 0/ Ensure that any raw file sidecar files (.xmps) are updated along side the
:: source raw files because image editors/organizers often hide the .xmp, so only the 
:: raw file name will have been passed on the command line.
:: 1/ Interpret the state in the environment variables - easy, currently they are 
:: command line options
:: 2/ Form a valid exiftool command line, including options and redirect files

:: runner_dir can be empty if the install folder is the working directory.

:: The caller can force these scripts to never look for sidecar files by setting 
:: sidecar_mode=ignore, but by default we will update any existing sidecar when it 
:: exists. 

:: Action.txt files that include -execute can only be run with sidecar_mode=ignore, 
:: because in that case the %action_params% can not be after (part of) the common_args.
@if [%sidecar_mode%]==[ignore] (
    set opts=%action_params% -common_args %extra_common_args%
	) else ( 
	set opts=-execute -if "-e $filepath" -srcfile "%%%%d%%%%f.xmp" -@ "%runner_dir%_sidecarFormats.txt" -common_args %action_params% %extra_common_args%
)

@ IF DEFINED outfile (
    set "out_redirect=1>"%outfile%""
)

::Ignore whitespace example for command options
::-api "Filter=s/\s+//g"
call "%runner_dir%exiftool.exe" %opts% -@ "%runner_dir%_interactiveOptions.txt" %* %out_redirect%
:: Options after -common_args will be added to the options within any -execute on this command line or config file.
