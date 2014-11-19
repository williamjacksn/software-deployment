goto [%PROCESSOR_ARCHITECTURE%-%1]
goto []

:[x86-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning TortoiseSVN install (32-bit Windows)..."
msiexec.exe /package "%~dp0TortoiseSVN-1.8.7.25475-win32-svn-1.8.9.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 2 /d "Ending TortoiseSVN install (32-bit Windows)..."
goto []

:[x86-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning TortoiseSVN uninstall (32-bit Windows)..."
msiexec.exe /uninstall "%~dp0TortoiseSVN-1.8.7.25475-win32-svn-1.8.9.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 4 /d "Ending TortoiseSVN uninstall (32-bit Windows)..."
goto []

:[AMD64-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning TortoiseSVN install (64-bit Windows)..."
msiexec.exe /package "%~dp0TortoiseSVN-1.8.7.25475-x64-svn-1.8.9.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 2 /d "Ending TortoiseSVN install (64-bit Windows)..."
goto []

:[AMD64-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning TortoiseSVN uninstall (64-bit Windows)..."
msiexec.exe /uninstall "%~dp0TortoiseSVN-1.8.7.25475-x64-svn-1.8.9.msi" /quiet /norestart
eventcreate /l application /t information /so SCCM /id 4 /d "Ending TortoiseSVN uninstall (64-bit Windows)..."
goto []

:[]
