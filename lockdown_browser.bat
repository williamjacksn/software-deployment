goto [%1]
goto []

:[detect]
PowerShell.exe -NoLogo -ExecutionPolicy Bypass -File "%~dp0lockdown_browser_detect.ps1"
goto []

:[record]
"%~dp0setup.exe" /r /f1"%~dp0record.iss"
goto []

:[install]
"%~dp0setup.exe" /s /f1"%~dp0install.iss"
goto []

:[uninstall]
"%~dp0setup.exe" /s /f1"%~dp0uninstall.iss"
goto []

:[]
