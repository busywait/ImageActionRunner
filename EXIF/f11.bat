:: This sets a single value for a single tag (do not use quotes around the value or tag name)
@set tag=FNumber
@set value=11
@set %runner_dir%=%~dp0
@call "%runner_dir%Set From Prompt.bat" %*
