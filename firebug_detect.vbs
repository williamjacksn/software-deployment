Set sh = CreateObject("WScript.Shell")
program_files = sh.ExpandEnvironmentStrings("%ProgramFiles(x86)%")
If program_files = "%ProgramFiles(x86)%" Then
    program_files = sh.ExpandEnvironmentStrings("%ProgramFiles%")
End If
target = program_files & "\Mozilla Firefox\browser\extensions\firebug@software.joehewitt.com\install.rdf"

Set fso = CreateObject("Scripting.FileSystemObject")
If fso.FileExists(target) Then
    iomode = 1  ' read_only
    Set f = fso.OpenTextFile(target, iomode)
    If f.AtEndOfStream Then
        content = ""
    Else
        content = f.ReadAll
    End If
    If InStr(content, "<em:version>1.12.8</em:version>") > 0 Then
        WScript.Echo "Detected"
    End If
End If
