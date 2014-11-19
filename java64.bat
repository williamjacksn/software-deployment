goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Java Runtime (64-bit) install..."
for %%a in ("%~dp0*.msi") do msiexec.exe /package "%%a" /quiet /norestart /l*v "%windir%\Temp\_jre_64_install.log" AUTO_UPDATE=Disable
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Java Runtime (64-bit) install..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Java Runtime (64-bit) uninstall..."
for %%a in ("%~dp0*.msi") do msiexec.exe /uninstall "%%a" /quiet /norestart /l*v "%windir%\Temp\_jre_64_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Java Runtime (64-bit) uninstall..."
goto []

:[]
