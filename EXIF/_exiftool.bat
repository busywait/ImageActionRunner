:: Responsibilities of _exiftool.bat
:: 1/ Interpret the state in the environment variables
:: 2/ Form a valid exiftool command line, including options and redirect files

:: runner_dir can be empty if the install folder is the working directory.

:: The caller can force these scripts to never look for sidecar files,
:: but by default we will update any existing sidecar when it exists 
@if [%sidecar_mode%]==[ignore] (
    set "sidecar_opts="
	) else ( 
	set sidecar_opts=-execute -if "-e $filepath" -srcfile "%%%%d%%%%f.xmp" -@ "%runner_dir%_sidecarFormats.txt" -common_args
)
:: The -execute option causes a run of the command before running again with the options between -execute and -common_args

@ IF DEFINED outfile (
    set "out_redirect=1>"%outfile%""
)
call "%runner_dir%exiftool.exe" %sidecar_opts% -@ "%runner_dir%_interactiveOptions.txt" %* %out_redirect%