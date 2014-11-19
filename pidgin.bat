goto [%PROCESSOR_ARCHITECTURE%-%1]
goto []

:[x86-install]
:[AMD64-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Pidgin install"
for %%a in ("%~dp0*.exe") do "%%a" /S
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Pidgin install"
goto []

:[x86-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Pidgin uninstall (32-bit Windows)"
"%ProgramFiles%\Pidgin\pidgin-uninst.exe" /S
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Pidgin uninstall (32-bit Windows)"
goto []

:[AMD64-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Pidgin uninstall (64-bit Windows)"
"%ProgramFiles(x86)%\Pidgin\pidgin-uninst.exe" /S
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Pidgin uninstall (64-bit Windows)"
goto []

:[]
