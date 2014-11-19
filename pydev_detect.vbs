Set sh = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

sys_drive = sh.ExpandEnvironmentStrings("%SystemDrive%")
target = sys_drive & "\Eclipse\dropins\features\org.python.pydev.feature_3.5.0.201405201709"

If fso.FolderExists(target) Then
    WScript.Echo "Detected"
End If
