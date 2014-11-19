Const UI_LEVEL_NONE = 2
Const INSTALL_STATE_ABSENT = 2
Const INSTALL_LEVEL_DEFAULT = 0

Set sh = CreateObject("WScript.Shell")
Set wi = CreateObject("WindowsInstaller.Installer")
wi.UILevel = UI_LEVEL_NONE

sh.LogEvent Information, "Here begins the Bomgar Rep Console uninstall script"

For Each p In wi.Products
    n = wi.ProductInfo(p, "ProductName")
    v = wi.ProductInfo(p, "VersionString")
    If InStr(n, "Bomgar Representative Console") > 0 Then
        m = "Attempting to uninstall " & p & " (" & n & " " & v & ")"
        sh.LogEvent Information, m
        wi.ConfigureProduct p, INSTALL_LEVEL_DEFAULT, INSTALL_STATE_ABSENT
    End If
Next
