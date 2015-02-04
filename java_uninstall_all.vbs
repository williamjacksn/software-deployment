Set sh = CreateObject("WScript.Shell")
Set wi = CreateObject("WindowsInstaller.Installer")

Const UI_LEVEL_NONE = 2
Const INSTALL_STATE_ABSENT = 2
Const IO_READ_ONLY = 1

wi.UILevel = UI_LEVEL_NONE

sh.LogEvent Information, "Beginning Java uninstall script"

exception = "None"
If WScript.Arguments.Named.Exists("except") Then
    exception = WScript.Arguments.Named.Item("except")
End If

For Each p In wi.Products
    n = wi.ProductInfo(p, "ProductName")
    If is_java(n) Then
        If InStr(n, exception) = 1 Then
            sh.LogEvent Information, "Found " & n & " but not uninstalling"
        Else
            sh.LogEvent Information, "Found " & n & ", attempting to uninstall"
            wi.ConfigureProduct p, 0, INSTALL_STATE_ABSENT
        End If
    End If
Next

sh.LogEvent Information, "Ending Java uninstall script"

Function is_java(n)
    is_java = False
    If InStr(n, "Java 2 Runtime") = 1 Then
        is_java = True
        Exit Function
    End If
    If InStr(n, "Java 7 Update") = 1 Then
        is_java = True
        Exit Function
    End If
    If InStr(n, "Java 8 Update") = 1 Then
        is_java = True
        Exit Function
    End If
    If InStr(n, "Java(TM) 6") = 1 Then
        is_java = True
        Exit Function
    End If
    If InStr(n, "Java(TM) 7") = 1 Then
        is_java = True
        Exit Function
    End If
End Function
