goto [%1]
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning System Center Endpoint Protection install ..."
"%~dp0scep.exe" /s /q
eventcreate /l application /t information /so SCCM /id 2 /d "Ending System Center Endpoint Protection install ..."
goto []

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning System Center Endpoint Protection uninstall ..."
"%~dp0scep.exe" /u /s /q
eventcreate /l application /t information /so SCCM /id 4 /d "Ending System Center Endpoint Protection uninstall ..."
goto []

:[]
