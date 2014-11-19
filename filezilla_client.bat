goto [%PROCESSOR_ARCHITECTURE%-%1]
goto []

:[x86-install]
:[AMD64-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning FileZilla Client install"
for %%a in ("%~dp0*.exe") do "%%a" /S
eventcreate /l application /t information /so SCCM /id 2 /d "Ending FileZilla Client install"
goto []

:[x86-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning FileZilla Client uninstall (32-bit Windows)"
"%ProgramFiles%\FileZilla FTP Client\uninstall.exe" /S
eventcreate /l application /t information /so SCCM /id 4 /d "Ending FileZilla Client uninstall (32-bit Windows)"
goto []

:[AMD64-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning FileZilla Client uninstall (64-bit Windows)"
"%ProgramFiles(x86)%\FileZilla FTP Client\uninstall.exe" /S
eventcreate /l application /t information /so SCCM /id 4 /d "Ending FileZilla Client uninstall (64-bit Windows)"
goto []

:[]
