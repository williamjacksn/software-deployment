goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Shockwave Player install..."
msiexec.exe /package "%~dp0sw_lic_full_installer.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Shockwave Player install..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Shockwave Player uninstall..."
msiexec.exe /uninstall "%~dp0sw_lic_full_installer.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Shockwave Player uninstall..."
goto []

:[]
