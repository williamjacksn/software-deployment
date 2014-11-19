@echo off
if "%processor_architecture%" == "x86" goto x86
msiexec.exe /i "%~dp0omcix64.msi" REBOOT=REALLYSUPPRESS /quiet /norestart
goto end
:x86
msiexec.exe /i "%~dp0omcix86.msi" REBOOT=REALLYSUPPRESS /quiet /norestart
:end
