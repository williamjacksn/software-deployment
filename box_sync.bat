goto [%PROCESSOR_ARCHITECTURE%-%1]
goto []

:[x86-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Box Sync install (32-bit Windows) ..."
for %%a in ("%~dp0*32.msi") do msiexec.exe /package "%%a" /quiet /norestart /l*vx C:\Windows\Temp\_box_sync_install.log
"%~dp0pskill.exe" -accepteula BoxSync.exe
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Box Sync install (32-bit Windows) ..."
goto []

:[AMD64-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Box Sync install (64-bit Windows) ..."
for %%a in ("%~dp0*64.msi") do msiexec.exe /package "%%a" /quiet /norestart /l*vx C:\Windows\Temp\_box_sync_install.log
"%~dp0pskill.exe" -accepteula BoxSync.exe
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Box Sync install (64-bit Windows) ..."
goto []

:[x86-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Box Sync uninstall (32-bit Windows) ..."
for %%a in ("%~dp0*32.msi") do msiexec.exe /uninstall "%%a" /quiet /norestart /l*vx C:\Windows\Temp\_box_sync_uninstall.log
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Box Sync uninstall (32-bit Windows) ..."
goto []

:[AMD64-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Box Sync uninstall (64-bit Windows) ..."
for %%a in ("%~dp0*64.msi") do msiexec.exe /uninstall "%%a" /quiet /norestart /l*vx C:\Windows\Temp\_box_sync_uninstall.log
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Box Sync uninstall (64-bit Windows) ..."
goto []

:[]
