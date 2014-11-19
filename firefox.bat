goto [%PROCESSOR_ARCHITECTURE%-%1]
goto []

:[x86-install]
:[AMD64-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Firefox install"
for %%a in ("%~dp0*.exe") do "%%a" /ini="%~dp0firefox.ini"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Firefox install"
goto []

:[x86-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Firefox uninstall (32-bit Windows)"
"%ProgramFiles%\Mozilla Firefox\uninstall\helper.exe" /S
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Firefox uninstall (32-bit Windows)"
goto []

:[AMD64-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Firefox uninstall (64-bit Windows)"
"%ProgramFiles(x86)%\Mozilla Firefox\uninstall\helper.exe" /S
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Firefox uninstall (64-bit Windows)"
goto []

:[]
