Set sh = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set app = CreateObject("Shell.Application")

install_pydev

Sub install_pydev
    src_path = Replace(WScript.ScriptFullName, WScript.ScriptName, "")
    src_folder = src_path & "PyDev 3.5.0.zip"

    create_folder target_folder
    copy_folder_contents src_folder, target_folder
End Sub

Sub create_folder(folder_path)
    If fso.FolderExists(folder_path) Then
        Exit Sub
    End If
    fso.CreateFolder(folder_path)
End Sub

Function target_folder
    sys_drive = sh.ExpandEnvironmentStrings("%SystemDrive%")
    target_folder = sys_drive & "\Eclipse\dropins"
End Function

Sub copy_folder_contents(src, dst)
    Set src_files = app.NameSpace(src).Items
    Const HIDE_PROGRESS_DIALOG = 4
    Const YES_TO_ALL = 16
    Const FORCE_NEW_DIR = 512
    copy_options = HIDE_PROGRESS_DIALOG + YES_TO_ALL + FORCE_NEW_DIR
    app.NameSpace(dst).CopyHere src_files, copy_options
End Sub
