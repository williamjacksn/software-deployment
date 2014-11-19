' Bomgar Jump Client 14.2.1

product_code_32 = "{d704170f-8d2d-4ea9-9a0e-a9e47c6f6c4d}"
product_code_64 = "{b16015ce-93ba-4977-94bc-5e794f227c1c}"

Set wi = CreateObject("WindowsInstaller.Installer")

Const UI_LEVEL_NONE = 2
Const INSTALL_STATE_ABSENT = 2

wi.UILevel = UI_LEVEL_NONE

For Each p In wi.Products
    If LCase(p) = LCase(product_code_32) Then
        wi.ConfigureProduct product_code_32, 0, INSTALL_STATE_ABSENT
    End If
    If LCase(p) = LCase(product_code_64) Then
        wi.ConfigureProduct product_code_64, 0, INSTALL_STATE_ABSENT
    End If
Next
