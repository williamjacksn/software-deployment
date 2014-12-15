eventcreate /l application /t information /so SCCM /id 5 /d "%~dpnx0 %*"
set app_name=FileMaker Pro
set app_file_name=filemaker_pro

goto [%1]
goto []

:[update]
eventcreate /l application /t information /so SCCM /id 1 /d "Beginning %app_name% update"
"%~dp0setup.exe" /s /v"/quiet /norestart /l*v %windir%\Temp\_%app_file_name%_update.log"
eventcreate /l application /t information /so SCCM /id 2 /d "Ending %app_name% update"
goto []

:[]
