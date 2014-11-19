goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Absolute Manage Admin install..."
"%~dp0setup.exe" /s /v"/quiet /norestart"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Absolute Manage Admin install..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Absolute Manage Admin uninstall..."
msiexec.exe /uninstall "%~dp0LANrev Admin.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Absolute Manage Admin uninstall..."
goto []

:[]
