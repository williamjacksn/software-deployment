' install python, by william jackson (w@utexas.edu)
' last edited 2010-02-18 for version 2.6.4

' this script will deploy python

' set up variables that may change with new versions of this script
str_program_name = "Python"
str_program_exe_32 = "python-2.6.4.msi"
str_program_exe_64 = "python-2.6.4.amd64.msi"
str_log = "python-install.log"
bool_log = false

' set up constants and variables
set obj_shell = wscript.createobject("wscript.shell")
str_log_prefix = wscript.scriptfullname & " : The " & str_program_name & " installation script "
str_public = obj_shell.expandenvironmentstrings("%public%")
if str_public = "%public%" then
  str_public = obj_shell.expandenvironmentstrings("%allusersprofile%")
end if

' announce start
obj_shell.logevent information, str_log_prefix & "has started."

' detect architecture
const hive_hklm = &H80000002
set obj_reg = getobject("winmgmts:{impersonationLevel=impersonate}\\.\root\default:StdRegProv")
str_arch_key = "system\currentcontrolset\control\session manager\environment\"
str_arch_val_name = "processor_architecture"
obj_reg.getstringvalue hive_hklm, str_arch_key, str_arch_val_name, str_arch_val_data
obj_shell.logevent information, str_log_prefix & "detected the following architecture: " & str_arch_val_data

' set architecture-specific options
if str_arch_val_data = "x86" then
	str_program_exe = str_program_exe_32
else
	str_program_exe = str_program_exe_64
end if

' set install command
str_install_cmd = "msiexec.exe /i " & str_program_exe & " /quiet ALLUSERS=1"
if bool_log then
  str_install_cmd = str_install_cmd & " /log " & str_public & "\documents\" & str_log
end if

' install
int_install_result = obj_shell.run(str_install_cmd, 0, true)
if int_install_result = 0 then
  obj_shell.logevent information, str_log_prefix & "installed " & str_program_name & "." & vbcrlf & "Command: " & str_install_cmd & vbcrlf & "Exit code: " & int_install_result
else
  obj_shell.logevent information, str_log_prefix & "encountered an error installing " & str_program_name & "." & vbcrlf & "Command: " & str_install_cmd & vbcrlf & "Exit code: " & int_install_result
end if

' announce end
obj_shell.logevent information, str_log_prefix & "has ended."
