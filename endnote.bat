goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning EndNote install..."
cscript.exe //nologo "%~dp0endnote.vbs"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending EndNote install..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning EndNote uninstall..."
msiexec.exe /uninstall {86b3f2d6-ac2b-0015-8ae1-f2f77f781b0c} /quiet /norestart /l*vx C:\Windows\Temp\_endnote_uninstall.log
eventcreate /l application /t information /so SCCM /id 4 /d "Ending EndNote uninstall..."
goto []

:[]
