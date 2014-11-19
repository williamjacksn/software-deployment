goto [%1]
goto []

:[detect]
cscript.exe //nologo "%~dp0pydev_detect.vbs"
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning PyDev install..."
cscript.exe //nologo "%~dp0pydev.vbs"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending PyDev install..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning PyDev uninstall..."
for /d %%a in ("%SystemDrive%\Eclipse\dropins\features\org.python.pydev*") do rmdir /s /q %%a
for /d %%a in ("%SystemDrive%\Eclipse\dropins\plugins\???.python.pydev*") do rmdir /s /q %%a
eventcreate /l application /t information /so SCCM /id 4 /d "Ending PyDev uninstall..."
goto []

:[]
