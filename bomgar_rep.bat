goto [%PROCESSOR_ARCHITECTURE%-%1]
goto []

:[x86-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Bomgar Representative Console install (32-bit Windows)"
msiexec.exe /package "%~dp0bomgar-rep-win32-installer.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Bomgar Representative Console install (32-bit Windows)"
goto []

:[AMD64-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Bomgar Representative Console install (64-bit Windows)"
msiexec.exe /package "%~dp0bomgar-rep-win64-installer.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Bomgar Representative Console install (64-bit Windows)"
goto []

:[x86-uninstall]
:[AMD64-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Bomgar Representative Console uninstall"
cscript.exe //nologo "%~dp0bomgar_rep.vbs"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Bomgar Representative Console uninstall"
goto []

:[]
