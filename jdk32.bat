goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Java Development Kit (32-bit) install..."
msiexec.exe /package "%~dp0jdk1.7.0_60.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Java Development Kit (32-bit) install..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Java Development Kit (32-bit) uninstall..."
msiexec.exe /uninstall "%~dp0jdk1.7.0_60.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Java Development Kit (32-bit) uninstall..."
goto []

:[]
