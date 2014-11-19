' Install Adobe Reader XI, by William Jackson (w@utexas.edu)
' Last edited 2014-09-25 for version 11.0.09

' This script will deploy Adobe Reader XI. it will check for an installed
' version of Adobe Reader XI, and install updates as necessary

' Things we need for the log
q = Chr(34)
Set sh = CreateObject("WScript.Shell")
program_name = "Adobe Reader XI"
log_prefix = WScript.ScriptFullName & " : The " & program_name & " installation script "

' Announce start
sh.LogEvent Information, log_prefix & "has started."

path = Replace(WScript.ScriptFullName, WScript.ScriptName, "")
sh.LogEvent Information, log_prefix & "was launched with path: " & path

' Assume Adobe Reader XI is not installed
reader_installed = False

' Look for Adobe Reader XI and jump to appropriate point in patch sequence
Set wi = CreateObject("WindowsInstaller.Installer")
Const UI_LEVEL_NONE = 2
wi.UILevel = UI_LEVEL_NONE
For Each p In wi.Products
  n = wi.ProductInfo(p, "ProductName")
  If InStr(n, program_name) > 0 Then
    reader_installed = True
    Select Case wi.ProductInfo(p, "VersionString")
      Case "11.0.00" install_11008
      Case "11.0.01" install_11008
      Case "11.0.02" install_11008
      Case "11.0.03" install_11008
      Case "11.0.04" install_11008
      Case "11.0.05" install_11008
      Case "11.0.06" install_11008
      Case "11.0.07" install_11008
      Case "11.0.08" install_11009
      Case "11.0.09" sh.LogEvent Information, log_prefix & "found version 11.0.09 and will not install any updates."
      Case Else sh.LogEvent Information, log_prefix & "found an existing version that it was not expecting." & VbCrLf & "Version found: " & p.Version
    End Select
    Exit For
  End If
Next

' If we did not find Adobe Reader XI, start installation at the beginning
If Not reader_installed Then
  install_11008
End If

' Announce end
sh.LogEvent Information, log_prefix & "ended."

Sub install_11008
  install_cmd = q & path & "AdbeRdr11008_en_US.exe" & q & " /sAll /rs /msi /l*v C:\Windows\Temp\_adobe_reader_install.log TRANSFORMS=" & q & path & "reader.mst" & q
  sh.LogEvent Information, log_prefix & "is trying to install with:" & VbCrLf & install_cmd
  result = sh.Run(install_cmd, 0, True)
  sh.LogEvent Information, log_prefix & "exited with result: " & result
  install_11009
End Sub

Sub install_11009
  install_cmd = "msiexec.exe /update " & q & path & "AdbeRdrUpd11009.msp" & q & " /quiet /norestart /l*v C:\Windows\Temp\_adobe_reader_update.log"
  sh.LogEvent Information, log_prefix & "is trying to install with:" & VbCrLf & install_cmd
  result = sh.Run(install_cmd, 0, True)
  sh.LogEvent Information, log_prefix & "exited with result: " & result
End Sub
