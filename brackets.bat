goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Brackets install"
for %%a in ("%~dp0*.msi") do msiexec.exe /package "%%a" /quiet /norestart /l*v "%windir%\Temp\_brackets_install.log"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Brackets install"
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Brackets uninstall"
for %%a in ("%~dp0*.msi") do msiexec.exe /uninstall "%%a" /quiet /norestart /l*v "%windir%\Temp\_brackets_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Brackets uninstall"
goto []

:[]
