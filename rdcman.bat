eventcreate /l application /t information /so SCCM /id 5 /d "%~dpnx0 %*"
set app_name=Remote Desktop Connection Manager
set app_file_name=remote_desktop_connection_manager

goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% install"
for %%a in ("%~dp0*.msi") do msiexec.exe /package "%%a" /quiet /norestart /l*v "%windir%\Temp\_%app_file_name%_install.log"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% install"
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall"
for %%a in ("%~dp0*.msi") do msiexec.exe /uninstall "%%a" /quiet /norestart /l*v "%windir%\Temp\_%app_file_name%_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall"
goto []

:[]
