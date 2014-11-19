Set sh = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set app = CreateObject("Shell.Application")

install_firebug

Sub install_firebug
    src_path = Replace(WScript.ScriptFullName, WScript.ScriptName, "")
    src_folder = src_path & "firebug-1.12.8-fx.xpi.zip"

    create_folder extensions_folder
    create_folder target_folder
    copy_folder_contents src_folder, target_folder
End Sub

Sub create_folder(folder_path)
    If fso.FolderExists(folder_path) Then
        Exit Sub
    End If
    fso.CreateFolder(folder_path)
End Sub

Function extensions_folder
    program_files = sh.ExpandEnvironmentStrings("%ProgramFiles(x86)%")
    If program_files = "%ProgramFiles(x86)%" Then
        program_files = sh.ExpandEnvironmentStrings("%ProgramFiles%")
    End If
    extensions_folder = program_files & "\Mozilla Firefox\browser\extensions"
End Function

Function target_folder
    target_folder = extensions_folder & "\firebug@software.joehewitt.com"
End Function

Sub copy_folder_contents(src, dst)
    Set src_files = app.NameSpace(src).Items
    Const HIDE_PROGRESS_DIALOG = 4
    Const YES_TO_ALL = 16
    Const FORCE_NEW_DIR = 512
    copy_options = HIDE_PROGRESS_DIALOG + YES_TO_ALL + FORCE_NEW_DIR
    app.NameSpace(dst).CopyHere src_files, copy_options
End Sub
