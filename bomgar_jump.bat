goto [%PROCESSOR_ARCHITECTURE%-%1]
goto []

:[x86-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Bomgar Jump Client install (32-bit Windows)..."
msiexec.exe /package "%~dp0bomgar-scc-win32.msi" /quiet /norestart KEY_INFO=w0dc30e677hxzdxjex86fg5d1wg515h7ghe8xhc40jc90 INSTALLDIR="%ProgramFiles%\Bomgar Jump Client"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Bomgar Jump Client install (32-bit Windows)..."
goto []

:[AMD64-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Bomgar Jump Client install (64-bit Windows)..."
msiexec.exe /package "%~dp0bomgar-scc-win64.msi" /quiet /norestart KEY_INFO=w0dc30e677hxzdxjex86fg5d1wg515h7ghe8xhc40jc90 INSTALLDIR="%ProgramFiles%\Bomgar Jump Client"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Bomgar Jump Client install (64-bit Windows)..."
goto []

:[x86-uninstall]
:[AMD64-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Bomgar Jump Client uninstall..."
cscript.exe //nologo "%~dp0bomgar_jump.vbs"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Bomgar Jump Client uninstall..."
goto []

:[]
