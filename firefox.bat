eventcreate /l application /t information /so SCCM /id 5 /d "%~dpnx0 %*"
set app_name=Firefox
set app_file_name=firefox

goto [%PROCESSOR_ARCHITECTURE%-%1]
goto []

:[x86-install]
:[AMD64-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% install"
for %%a in ("%~dp0*.exe") do "%%a" /ini="%~dp0firefox.ini"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% install"
goto []

:[x86-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall (32-bit Windows)"
"%ProgramFiles%\Mozilla Firefox\uninstall\helper.exe" /S
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall (32-bit Windows)"
goto []

:[AMD64-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall (64-bit Windows)"
"%ProgramFiles(x86)%\Mozilla Firefox\uninstall\helper.exe" /S
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall (64-bit Windows)"
goto []

:[]
