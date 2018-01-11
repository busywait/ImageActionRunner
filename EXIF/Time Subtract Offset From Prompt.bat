:: AllDates is a shortcut for 3 tag names: DateTimeOriginal, CreateDate and ModifyDate. 
::@set "tag=AllDates"
::@set "tag2=TrackCreateDate"
::@set "tag3=TrackModifyDate"
::@set "tag4=MediaCreateDate"
::@set "tag5=MediaModifyDate"
@set "tag=Time:All"
@set "tag2=FileCreateDate"
@set "tag3=FileModifyDate"
:: Not needed because the back shift value will not add new values 
:: assume that our time shift is unique enough to not exist already as a string list tag value
:: @set extra_common_args=-wm w
:: eg, -DateTimeOriginal-=5:10:2 10:48:0”
@set "userPrompt=Offset to subtract in YYYY:mm:dd HH:MM:SS (1 = 1 hour; 0:90 = 90 minutes; 0:0:120 = 120 seconds)"
:: Assign Type: + to add or append, - to subtract or remove, blank to replace.
@set "assignType=-"
@call "%~dp0\Set From Prompt.bat" %*

