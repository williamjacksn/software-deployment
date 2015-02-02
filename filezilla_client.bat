eventcreate /l application /t information /so SCCM /id 5 /d "%~dpnx0 %*"
set app_name=FileZilla Client
set app_file_name=filezilla_client

goto [%PROCESSOR_ARCHITECTURE%-%1]
goto []

:[x86-install]
:[AMD64-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% install"
for %%a in ("%~dp0*.exe") do "%%a" /S
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% install"
goto []

:[x86-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall (32-bit Windows)"
"%ProgramFiles%\FileZilla FTP Client\uninstall.exe" /S
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall (32-bit Windows)"
goto []

:[AMD64-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall (64-bit Windows)"
"%ProgramFiles(x86)%\FileZilla FTP Client\uninstall.exe" /S
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall (64-bit Windows)"
goto []

:[]
