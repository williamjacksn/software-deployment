' install winmagic securedoc client, by william jackson (w@utexas.edu)
' based on work by scott keiffer (skeiffer@cm.utexas.edu)
' last edited 2011-10-25 for version 5.2 SR3

' this script will deploy winmagic securedoc client. it takes into
' account a bug when installing on Windows 7 x86.

' things we need for the log
set obj_shell = wscript.createobject("wscript.shell")
str_program_name = "WinMagic SecureDoc"
str_log_prefix = wscript.scriptfullname & " : The " & str_program_name & " installation script "

' announce start
obj_shell.logevent information, str_log_prefix & "has started."

Set obj_fso = createobject("scripting.filesystemobject")

str_scriptdir = replace(wscript.scriptfullname, "\" & wscript.scriptname, "")
str_programdir = obj_shell.expandenvironmentstrings("%programfiles%") & "\WinMagic\SecureDoc-NT\"

obj_shell.currentdirectory = str_scriptdir

arch = obj_shell.regread("HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\PROCESSOR_ARCHITECTURE")

' install
err = 0
if arch = "x86" then
	if not obj_fso.folderexists(str_programdir) then
		obj_fso.createfolder(obj_shell.expandenvironmentstrings("%programfiles%") & "\WinMagic")
		obj_fso.createfolder(str_programdir)
	end if
	obj_fso.copyfile str_scriptdir & "\Boot_msg.txt", str_programdir
	obj_fso.copyfile str_scriptdir & "\PackageSettings.ini", str_programdir
	obj_fso.copyfile str_scriptdir & "\SDConnex.cer", str_programdir
	obj_fso.copyfile str_scriptdir & "\SDProfile.spf", str_programdir
	err = obj_shell.run("msiexec /i SDSetupSilent.msi /quiet", 1, true)
else
	err = obj_shell.run("msiexec /i SD_x64.msi /quiet", 1, true)
end if

' announce end
obj_shell.logevent information, str_log_prefix & "has ended."

wscript.quit(err)
