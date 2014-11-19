goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Skype install..."
msiexec.exe /package "%~dp0SkypeSetup.msi" /quiet /norestart TRANSFORMS="%~dp0skype.mst"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Skype install..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Skype uninstall..."
msiexec.exe /uninstall "%~dp0SkypeSetup.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Skype uninstall..."
goto []

:[]
