eventcreate /l application /t information /so SCCM /id 5 /d "%~dpnx0 %*"

goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning UTBackup install"
cscript.exe //nologo "%~dp0utbackup_install.vbs" %2
eventcreate /l application /t information /so SCCM /id 2 /d "Ending UTBackup install"
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning UTBackup uninstall"
cscript.exe //nologo "%~dp0utbackup_uninstall.vbs"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending UTBackup uninstall"
goto []

:[]
