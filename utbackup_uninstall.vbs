Const UI_LEVEL_NONE = 2
Const INSTALL_LEVEL_DEFAULT = 0
Const INSTALL_STATE_ABSENT = 2
Const FORCE_DELETE = True

Set sh = CreateObject("WScript.Shell")
Set fs = CreateObject("Scripting.FileSystemObject")
Set wi = CreateObject("WindowsInstaller.Installer")
wi.UILevel = UI_LEVEL_NONE

sh.LogEvent Information, "Here begins the UTBackup uninstall script"

found = False
For Each p In wi.Products
    n = wi.ProductInfo(p, "ProductName")
    v = wi.ProductInfo(p, "VersionString")
    If InStr(n, "CrashPlan PROe") > 0 Then
        found = True
        uninstall p, n, v
    End If
Next

If Not found Then
    sh.LogEvent Information, "UTBackup is not installed"
End If

Sub uninstall(p, n, v)
    m = "Attempting to uninstall " & p & " (" & n & " " & v & ")"
    sh.LogEvent Information, m
    wi.ConfigureProduct p, INSTALL_LEVEL_DEFAULT, INSTALL_STATE_ABSENT

    program_data = sh.ExpandEnvironmentStrings("%ALLUSERSPROFILE%")
    folder = program_data & "\CrashPlan"
    If fs.FolderExists(folder) Then
        sh.LogEvent Information, "Attempting to delete " & folder
        fs.DeleteFolder program_data & "\CrashPlan", FORCE_DELETE
    End If
End Sub
