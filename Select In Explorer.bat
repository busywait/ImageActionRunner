:: Open Windows File Explorer with the specified file selected. This .bat 
:: file can be added in to Tools > External Editors in ACDSee to open the 
:: folder that a file is in with the file selected.
call explorer.exe /select,%1

:: Open File Explorer with the parent folder selected
::call explorer.exe /select,%~p1