eventcreate /l application /t information /so SCCM /id 5 /d "%~dpnx0 %*"
set app_name=Adobe Reader
set app_file_name=adobe_reader

goto [%1]
goto []

:[install]
:[task_sequence]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% install"
for %%a in ("%~dp0*.exe") do "%%a" /sAll /rs /msi /l*v "%windir%\Temp\_%app_file_name%_install.log" TRANSFORMS="%~dp0reader.mst"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% install"
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall"
msiexec.exe /uninstall {ac76ba86-7ad7-1033-7b44-ac0f074e4100} /quiet /norestart /l*v "%windir%\Temp\_%app_file_name%_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall"
goto []

:[]
