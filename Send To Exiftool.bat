:: A wrapper to run exiftool with some common options, and
:: do not try to find .xmp sidecar files for raw files.
:: This was written to be called from the Windows Send To menu.
:: Usage: $0 ACTION (FILE [FILE...]|DIR)
:: ACTION must be an absolute path.

@set runner_dir=%~dp0
@set sidecar_mode=ignore
:: When called from Send To %2 is either the start of a list of files or a dir 
@call %runner_dir%_setupRunner %2
@call %runner% -@ %*