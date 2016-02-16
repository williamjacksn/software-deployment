eventcreate /l application /t information /so SCCM /id 5 /d "%~dpnx0 %*"
set app_name=FileZilla Client
set app_file_name=filezilla_client

goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% install"
for %%a in ("%~dp0%PROCESSOR_ARCHITECTURE%\*.exe") do "%%a" /S
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% install"
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall"
"%ProgramFiles%\FileZilla FTP Client\uninstall.exe" /S
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall"
goto []

:[]
