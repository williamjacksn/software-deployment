goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Absolute Manage Agent install..."
"%~dp0setup.exe" /s /v"/quiet /norestart /l*vx C:\Windows\Temp\_absolute_manage_agent_install.log"
ping -n 60 localhost > nul
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Absolute Manage Agent install..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Absolute Manage Agent uninstall..."
msiexec.exe /uninstall "%~dp0LANrev Agent.msi" /quiet /norestart /l*vx C:\Windows\Temp\_absolute_manage_agent_uninstall.log
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Absolute Manage Agent uninstall..."
goto []

:[]
