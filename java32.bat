goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Java Runtime (32-bit) install..."
for %%a in ("%~dp0*.msi") do msiexec.exe /package "%%a" /quiet /norestart /l*v "%windir%\Temp\_jre_32_install.log" AUTO_UPDATE=Disable
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Java Runtime (32-bit) install..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Java Runtime (32-bit) uninstall..."
for %%a in ("%~dp0*.msi") do msiexec.exe /uninstall "%%a" /quiet /norestart /l*v "%windir%\Temp\_jre_32_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Java Runtime (32-bit) uninstall..."
goto []

:[]
