q = Chr(34)
Set wmi = GetObject("winmgmts:")
Set sh = CreateObject("WScript.Shell")

For Each o In wmi.InstancesOf("Win32_OperatingSystem")
    arch = o.OSArchitecture
Next

If arch = "32-bit" Then
    env = "%ProgramFiles%"
Else
    env = "%ProgramFiles(x86)%"
End If

cmd = q & sh.ExpandEnvironmentStrings(env) & "\VideoLAN\VLC\uninstall.exe" & q & " /S"
result = sh.Run(cmd, 0, True)

Do
    still_running = False
    WScript.Sleep 3000
    For Each p in wmi.InstancesOf("Win32_Process")
        If p.Name = "au_.exe" Then
            still_running = True
            Exit For
        End If
    Next
Loop While still_running

WScript.Quit(result)
