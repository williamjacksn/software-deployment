goto [%PROCESSOR_ARCHITECTURE%-%1]
goto []

:[x86-detect]
:[AMD64-detect]
cscript.exe //nologo "%~dp0firebug_detect.vbs"
goto []

:[x86-install]
:[AMD64-install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning Firebug install..."
cscript.exe //nologo "%~dp0firebug.vbs"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending Firebug install..."
goto []

:[x86-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Firebug uninstall (32-bit Windows)..."
rmdir /s /q "C:\Program Files\Mozilla Firefox\browser\extensions\firebug@software.joehewitt.com"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Firebug uninstall (32-bit Windows)..."
goto []

:[AMD64-uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning Firebug uninstall (64-bit Windows)..."
rmdir /s /q "C:\Program Files (x86)\Mozilla Firefox\browser\extensions\firebug@software.joehewitt.com"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending Firebug uninstall (64-bit Windows)..."
goto []

:[]
