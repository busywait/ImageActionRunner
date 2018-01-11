:: AllDates is a shortcut for 3 tag names: DateTimeOriginal, CreateDate and ModifyDate. 
::@set "tag=AllDates"
::@set "tag2=TrackCreateDate"
::@set "tag3=TrackModifyDate"
::@set "tag4=MediaCreateDate"
::@set "tag5=MediaModifyDate"
@set "tag=Time:All"
@set "tag2=FileCreateDate"
@set "tag3=FileModifyDate"
:: Write only to existing tags - needed because some "time" tags are actually string list values, 
:: and I don't want to append the offset as a string. (as of exiftool ver 10.74)
@set extra_common_args=-wm w
:: eg, -DateTimeOriginal-=5:10:2 10:48:0”
@set "userPrompt=Offset to add in YY:mm:dd HH:MM:SS (1 = 1 hour; 0:90 = 90 minutes; 0:0:120 = 120 seconds)"
:: Assign Type: + to add or append, - to subtract or remove, blank to replace.
@set "assignType=+"
@call "%~dp0\Set From Prompt.bat" %*

