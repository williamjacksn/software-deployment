goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Vagrant install ..."
for %%a in ("%~dp0*.msi") do msiexec.exe /package "%%a" /quiet /norestart /l*vx C:\Windows\Temp\_vagrant_install.log
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Vagrant install ..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Vagrant uninstall ..."
for %%a in ("%~dp0*.msi") do msiexec.exe /uninstall "%%a" /quiet /norestart /l*vx C:\Windows\Temp\_vagrant_uninstall.log
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Vagrant uninstall ..."
goto []

:[]
