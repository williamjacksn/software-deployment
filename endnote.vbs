q = Chr(34)

Set sh = CreateObject("WScript.Shell")
computer_name = LCase(sh.ExpandEnvironmentStrings("%COMPUTERNAME%"))
sh.LogEvent INFORMATION, "EndNote installation detected computer name: " & computer_name

Set fs = CreateObject("Scripting.FileSystemObject")
path = Replace(WScript.ScriptFullName, WScript.ScriptName, "")
file = path & "endnote.csv"
sh.LogEvent INFORMATION, "EndNote installation reading licenses from: " & file
Set csv = fs.OpenTextFile(file, 1)

serial = ""
pidkey = ""
Do Until csv.AtEndOfStream
    line = csv.ReadLine
    fields = Split(line, ",")
    line_computer_name = LCase(fields(0))
    If line_computer_name = computer_name Then
        serial = fields(1)
        sh.LogEvent INFORMATION, "EndNote installation found serial for " & computer_name & ": " & serial
        pidkey = fields(2)
        sh.LogEvent INFORMATION, "EndNote installation found pidkey for " & computer_name & ": " & pidkey
    End If
Loop

quoted_install_path = q & path & "ENX5Inst.exe" & q
quoted_patch_path = q & path & "EN1501Update.msp" & q
base_cmd = quoted_install_path & " /quiet /norestart /l*vx C:\Windows\Temp\_endnote_install.log PATCH=" & quoted_patch_path

If serial = "" Then
    sh.LogEvent INFORMATION, "EndNote installation did not find a serial for this computer, will install unlicensed"
    cmd = base_cmd
Else
    cmd = base_cmd & " SERIAL=" & serial & " PIDKEY=" & q & pidkey & q
End If

result = sh.Run(cmd, 0, True)
WScript.Quit(result)
