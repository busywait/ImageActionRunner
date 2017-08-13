:: AllDates is a shortcut for 3 tag names: DateTimeOriginal, CreateDate and ModifyDate. 
@set "tag=AllDates"
:: -DateTimeOriginal-=5:10:2 10:48:0”
@set "userPrompt=Offset to add in YY:mm:dd HH:MM:SS (1 = 1 hour; 0:90 = 90 minutes; 0:0:120 = 120 seconds)"
:: Assign Type: + to add or append, - to subtract or remove, blank to replace.
@set "assignType=+"
@call "%~dp0\Set From Prompt.bat" %*

