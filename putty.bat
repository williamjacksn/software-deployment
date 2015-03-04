eventcreate /l application /t information /so SCCM /id 5 /d "%~dpnx0 %*"
set app_name=PuTTY
set app_file_name=putty

goto [%PROCESSOR_ARCHITECTURE%-%1]
goto []

:[x86-install]
:[AMD64-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% install"
for %%a in ("%~dp0*.exe") do "%%a" /sp- /verysilent /norestart /log="%windir%\Temp\_%app_file_name%_install.log"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% install"
goto []

:[x86-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall (32-bit Windows)"
copy "%windir%\system32\print.exe" "%ProgramFiles%\PuTTY\putty.exe"
"%ProgramFiles%\PuTTY\unins000.exe" /verysilent /norestart /log="%windir%\Temp\_%app_file_name%_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall (32-bit Windows)"
goto []

:[AMD64-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall (64-bit Windows)"
copy "%windir%\system32\print.exe" "%ProgramFiles(x86)%\PuTTY\putty.exe"
"%ProgramFiles(x86)%\PuTTY\unins000.exe" /verysilent /norestart /log="%windir%\Temp\_%app_file_name%_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall (64-bit Windows)"
goto []

:[]
