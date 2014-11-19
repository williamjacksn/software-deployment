eventcreate /l application /t information /so SCCM /id 5 /d "%~dpnx0 %*"
set app_name=Flash Player Plugin
set app_file_name=flash_player_plugin

goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% install"
for %%a in ("%~dp0*.msi") do msiexec.exe /package "%%a" /quiet /norestart /l*v "%windir%\Temp\_%app_file_name%_install.log" REMOVE_PREVIOUS=YES
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% install"
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall"
for %%a in ("%~dp0*.msi") do msiexec.exe /uninstall "%%a" /quiet /norestart /l*v "%windir%\Temp\_%app_file_name%_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall"
goto []

:[]
