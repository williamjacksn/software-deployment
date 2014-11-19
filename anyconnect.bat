goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning AnyConnect install"
for %%a in ("%~dp0*.exe") do "%%a" /quiet /norestart /l*v "%windir%\Temp\_anyconnect_install.log"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending AnyConnect install"
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning AnyConnect uninstall"
msiexec.exe /uninstall {cc3bbf96-7a4c-4b1d-b34d-6ac88ce46c6c} /quiet /norestart /l*v "%windir%\Temp\_anyconnect_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending AnyConnect uninstall"
goto []

:[]
