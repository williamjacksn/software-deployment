eventcreate /l application /t information /so SCCM /id 5 /d "%~dpnx0 %*"
set app_name=Tableau
set app_file_name=tableau

goto [%1]
goto []

:[extract]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% extract"
for %%a in ("%~dp0*.exe") do "%%a" /t:"%~dp0" /c
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% extract"
goto []

:[install]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% install"
for %%a in ("%~dp0*.msi") do msiexec.exe /package "%%a" /quiet /norestart /l*v "%windir%\Temp\_%app_file_name%_install.log" DESKTOPSHORTCUT=0
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% install"
goto [license]

:[license]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% license"
for /f "usebackq" %%a in ("%~dp0license.txt") do "C:\Program Files\Tableau\Tableau 8.3\bin\tableau.exe" -activate %%a
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% license"
goto []

:[unlicense]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% license"
for /f "usebackq" %%a in ("%~dp0license.txt") do "C:\Program Files\Tableau\Tableau 8.3\bin\tableau.exe" -return %%a
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% license"
goto [uninstall]

:[uninstall]
eventcreate /l application /t information /so SCCM /id 3 /d "Beginning %app_name% uninstall"
for %%a in ("%~dp0*.msi") do msiexec.exe /uninstall "%%a" /quiet /norestart /l*v "%windir%\Temp\_%app_file_name%_uninstall.log"
eventcreate /l application /t information /so SCCM /id 4 /d "Ending %app_name% uninstall"
goto []

:[]
