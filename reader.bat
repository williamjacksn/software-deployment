goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Adobe Reader install ..."
cscript.exe //nologo "%~dp0reader.vbs"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Adobe Reader install ..."
goto []

:[task_sequence]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Adobe Reader task sequence install ..."
"%~dp0AdbeRdr11008_en_US.exe" /sAll /rs /msi /l*v "%windir%\Temp\_adobe_reader_install.log" TRANSFORMS="%~dp0reader.mst"
msiexec.exe /update "%~dp0AdbeRdrUpd11009.msp" /quiet /norestart /l*v "%windir%\Temp\_adobe_reader_update.log"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Adobe Reader task sequence install ..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Adobe Reader uninstall ..."
msiexec.exe /uninstall {AC76BA86-7AD7-1033-7B44-AB0000000001} /quiet /norestart /l*v "%windir%\Temp\_adobe_reader_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Adobe Reader uninstall ..."
goto []

:[]
