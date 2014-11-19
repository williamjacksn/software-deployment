goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Flash Player ActiveX install..."
for %%a in ("%~dp0*.msi") do msiexec.exe /package "%%a" /quiet /norestart REMOVE_PREVIOUS=YES
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Flash Player ActiveX install..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Flash Player ActiveX uninstall..."
for %%a in ("%~dp0*.msi") do msiexec.exe /uninstall "%%a" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Flash Player ActiveX uninstall..."
goto []

:[]
