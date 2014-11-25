eventcreate /l application /t information /so SCCM /id 5 /d "%~dpnx0 %*"
set app_name=Absolute Manage Admin
set app_file_name=absolute_manage_admin

goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% install"
"%~dp0setup.exe" /s /v"/quiet /norestart /l*v %windir%\Temp\_%app_file_name%_install.log"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% install"
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall"
msiexec.exe /uninstall "%~dp0LANrev Admin.msi" /quiet /norestart /l*v "%windir%\Temp\_%app_file_name%_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall"
goto []

:[]
