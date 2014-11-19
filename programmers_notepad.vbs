' install programmer's notepad, by william jackson (w@utexas.edu)
' last edited 2010-02-15 for version 2.0.10

' this script will deploy programmer's notepad. it can uninstall 2.0.8,
' which was deployed using a repackaged msi. the guid for 2.0.8 is unique
' to ut austin, and will only uninstall the repackaged msi.

' set up variables that may change with new versions of this script
str_pn_exe = "pn20101010.exe"
bool_uninstall_pn208 = true

' set up constants and variables
const hive_hklm = &H80000002
str_log_prefix = wscript.scriptfullname & " : The Programmer's Notepad installation script "
set obj_reg = getobject("winmgmts:{impersonationLevel=impersonate}\\.\root\default:StdRegProv")
set obj_shell = wscript.createobject("wscript.shell")

' announce start
obj_shell.logevent information, str_log_prefix & "has started."

' detect architecture, set appropriate registry locations
str_arch_key = "system\currentcontrolset\control\session manager\environment\"
str_arch_val_name = "processor_architecture"
obj_reg.getstringvalue hive_hklm, str_arch_key, str_arch_val_name, str_arch_val_data
obj_shell.logevent information, str_log_prefix & "detected the following architecture: " & str_arch_val_data

if str_arch_val_data = "x86" then
	str_uninstall_key = "software\microsoft\windows\currentversion\uninstall"
else
	str_uninstall_key = "software\wow6432node\microsoft\windows\currentversion\uninstall"
end if


' check for and uninstall previously deployed version (2.0.8)
if bool_uninstall_pn208 then
	str_pn208_guid = "{FF810C70-04C6-46E1-AA18-5314909386B1}"
	obj_reg.enumkey hive_hklm, str_uninstall_key, arr_uninstall_subkeys

	for each str_subkey in arr_uninstall_subkeys
		if str_subkey = str_pn208_guid then
			obj_shell.logevent information, str_log_prefix & "found a previously deployed version (2.0.8) in the Add/Remove Programs list."
			str_uninstall_cmd = "msiexec.exe /x " & str_pn208_guid & " /quiet"
			int_uninstall_result = obj_shell.run(str_uninstall_cmd, 0, true)
			obj_shell.logevent information, str_log_prefix & "uninstalled a previously deployed version (2.0.8) with the following exit code: " & int_uninstall_result
			exit for
		end if
	next
end if

' install
str_install_cmd = str_pn_exe & " /verysilent /mergetasks=""!desktopicon"""
int_install_result = obj_shell.run(str_install_cmd, 0, true)
obj_shell.logevent information, str_log_prefix & "installed Programmer's Notepad with the following exit code: " & int_install_result

' announce end
obj_shell.logevent information, str_log_prefix & "has ended."
