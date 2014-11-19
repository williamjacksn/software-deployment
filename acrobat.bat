goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Acrobat Pro XI install"
cscript.exe //nologo "%~dp0acrobat_install.vbs"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Acrobat Pro XI install"
goto []

:[task_sequence]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Acrobat Pro XI task sequence install"
"%~dp0Setup.exe"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Acrobat Pro XI task sequence install"
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Acrobat Pro XI uninstall"
msiexec.exe /uninstall "%~dp0AcroPro.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Acrobat Pro XI uninstall"
goto []

:[]
