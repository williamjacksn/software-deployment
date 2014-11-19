goto [%1]
goto []

:[extract]
for %%a in ("%~dp0*.exe") do "%%a" -extract
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning VirtualBox install ..."
certutil -f -addstore TrustedPublisher "%~dp0virtualbox.cer"
for %%a in ("%~dp0*%PROCESSOR_ARCHITECTURE%.msi") do msiexec.exe /package "%%a" /quiet /norestart /l*v "%windir%\Temp\_virtualbox_install.log"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending VirtualBox install ..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning VirtualBox uninstall ..."
for %%a in ("%~dp0*%PROCESSOR_ARCHITECTURE%.msi") do msiexec.exe /uninstall "%%a" /quiet /norestart /l*v "%windir%\Temp\_virtualbox_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending VirtualBox uninstall ..."
goto []

:[]
