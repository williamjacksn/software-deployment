' Install UTBackup, by William Jackson (w@utexas.edu)
' Last edited 2014-11-17 for version 3.6.4

' This script will deploy CrashPlan (also known as UTBackup)
' Launch this way, replacing `its-css` with the desired org:

' cscript.exe utbackup_install.vbs its-css

q = Chr(34)
Set sh = CreateObject("WScript.Shell")
Set fs = CreateObject("Scripting.FileSystemObject")
program_name = "UTBackup"
log_prefix = WScript.ScriptFullName & " : The " & program_name & " installation script "

sh.LogEvent INFORMATION, log_prefix & "has started."

For Each o In GetObject("winmgmts:").InstancesOf("Win32_OperatingSystem")
  arch = o.OSArchitecture
Next

path = Replace(WScript.ScriptFullName, "\" & WScript.ScriptName, "")

temp = sh.ExpandEnvironmentStrings("%windir%") & "\Temp\"
dst_folder = temp & fs.GetTempName()
cr = fs.CreateFolder(dst_folder)

src_folder = path & "\" & arch
cp = fs.CopyFolder(src_folder, dst_folder)
sh.LogEvent INFORMATION, log_prefix & "copied installation files to " & dst_folder

Set args = WScript.Arguments
If args.Count > 0 Then
    org = args(0)
    sh.LogEvent INFORMATION, log_prefix & "was launched with org: " & org
Else
    org = "none"
    sh.LogEvent Information, log_prefix & "was launched without an org, using" & q & org & q & "."
End If

src_file = path & "\custom\custom.properties." & org
dst_file = dst_folder & "\custom\custom.properties"
cp = fs.CopyFile(src_file, dst_file)

If arch = "32-bit" Then
  sh.LogEvent INFORMATION, log_prefix & "detected a 32-bit operating system."
  program_msi = "Installer.msi"
Else
  sh.LogEvent INFORMATION, log_prefix & "detected a 64-bit operating system."
  program_msi = "Installer-x64.msi"
End If

install_cmd = "msiexec.exe /package " & q & dst_folder & "\" & program_msi & q & " /quiet /norestart /l*v " & temp & "_utbackup_install.log CP_SILENT=true"
sh.LogEvent INFORMATION, log_prefix & "is about to install " & program_name & "." & vbCrLf & "Command: " & install_cmd
install_result = sh.Run(install_cmd, 0, True)
sh.LogEvent INFORMATION, log_prefix & "installed " & program_name & "." & vbCrLf & "Command: " & install_cmd & vbCrLf & "Exit code: " & install_result

Const FORCE_DELETE = True
df = fs.DeleteFolder(dst_folder, FORCE_DELETE)

sh.LogEvent INFORMATION, log_prefix & "has ended."

WScript.Quit(install_result)
