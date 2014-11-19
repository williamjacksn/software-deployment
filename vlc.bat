goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning VLC media player install ..."
for %%a in ("%~dp0*.exe") do "%%a" /S
eventcreate /l application /t information /so SCCM /id 2 /d "Ending VLC media player install ..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning VLC media player uninstall ..."
cscript.exe //nologo "%~dp0vlc_uninstall.vbs"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending VLC media player uninstall ..."
goto []

:[]
