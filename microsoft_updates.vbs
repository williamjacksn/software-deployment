' Install Microsoft Updates. Skip Language Packs, Internet Explorer, and Bing.

Option Explicit

Dim debug, dry_run, task_sequence, arg
debug = False
dry_run = False
task_sequence = False

For Each arg In WScript.Arguments
    If arg = "debug" Then
        debug = True
    End If
    If arg = "dry_run" Then
        dry_run = True
        debug = True
    End If
    If arg = "task_sequence" Then
        debug = True
        task_sequence = True
    End If
Next

If task_sequence Then
    Dim env, p
    Set env = CreateObject("Microsoft.SMS.TSEnvironment")
    Set p = CreateObject("Microsoft.SMS.TSProgressUI")

    Dim org_name, ts_name, step_name, step_num, max_step
    org_name = env("_SMSTSOrgName")
    ts_name = env("_SMSTSPackageName")
    step_name = env("_SMSTSCurrentActionName")
    step_num = CLng(env("_SMSTSNextInstructionPointer"))
    max_step = CLng(env("_SMSTSInstructionTableSize"))
End If

' Create session
Dim update_session
Set update_session = CreateObject("Microsoft.Update.Session")

Dim update_searcher
Set update_searcher = update_session.CreateUpdateSearcher()
update_searcher.CanAutomaticallyUpgradeService = True

' Turn on Microsoft Update
print_debug "Turning on Microsoft Update", 1
turn_on_microsoft_update
update_searcher.ServerSelection = 3
update_searcher.ServiceID = "7971f918-a847-4430-9279-4a52d1efe18d"

' Create list of updates to download
Dim updates_to_download
Set updates_to_download = CreateObject("Microsoft.Update.UpdateColl")

' Search for updates
print_debug "Searching for updates", 2
Dim search_result
Set search_result = update_searcher.Search("IsInstalled=0")

' Quit if no updates were found
If search_result.Updates.Count = 0 Then
    print_debug "Did not find any updates", 10
    WScript.Quit
End If

' Clear the updates_to_download queue
updates_to_download.Clear

' Loop through each update, filter out unwanted updates, add it to the queue
Dim update
For Each update In search_result.Updates
    If update_is_wanted(update) Then
        print_debug "Will download: " & update.Title, 2
        updates_to_download.Add(update)
    Else
        print_debug "Not wanted: " & update.Title, 2
    End If
Next

Dim debug_msg
debug_msg = "Will download " & updates_to_download.Count & " update"
If updates_to_download.Count <> 1 Then
    debug_msg = debug_msg & "s"
End If
print_debug debug_msg, 3

If updates_to_download.Count = 0 Then
    WScript.Quit
End If

If dry_run Then
    print_debug "Dry run will stop here", 10
    WScript.Quit
End If

' Download updates
Dim update_downloader
Set update_downloader = update_session.CreateUpdateDownloader() 
update_downloader.Updates = updates_to_download

On Error Resume Next
print_debug "Downloading updates", 4
update_downloader.Download()

If Err.Number <> 0 Then
    WScript.Quit(Err.Number)
End If

On Error Goto 0

' Create list of updates to install
Dim updates_to_install
Set updates_to_install = CreateObject("Microsoft.Update.UpdateColl")

' Parse only the downloaded updates
For Each update In updates_to_download
    If update.IsDownloaded Then
        print_debug "Will install: " & update.Title, 5
        updates_to_install.Add(update)
    Else
        print_debug "Not downloaded: " & update.Title, 5
    End If
Next

debug_msg = "Will install " & updates_to_install.Count & " update"

If updates_to_install.Count <> 1 Then
    debug_msg = debug_msg & "s"
End If
print_debug debug_msg, 6

If updates_to_install.Count = 0 Then
    WScript.Quit
End If

' Install updates
Dim update_installer
Set update_installer = update_session.CreateUpdateInstaller()
update_installer.Updates = updates_to_install

On Error Resume Next
print_debug "Installing updates", 7
Dim installation_result
Set installation_result = update_installer.Install()

If Err.Number <> 0 Then
    Err.Clear
End If

If installation_result.RebootRequired Then
    print_debug "Reboot required", 10
    WScript.Quit(3010)
End If

WScript.Quit

' Check whether this is an update I want
Function update_is_wanted(u)
    update_is_wanted = True
    If InStr(u.Title, "Windows Internet Explorer 9 for") = 1 Then
        update_is_wanted = False
        Exit Function
    End If
    If InStr(u.Title, "Internet Explorer 10 for") = 1 Then
        update_is_wanted = False
        Exit Function
    End If
    If InStr(u.Title, "Internet Explorer 11 for") = 1 Then
        update_is_wanted = False
        Exit Function
    End If
    If InStr(u.Title, "Bing") = 1 Then
        update_is_wanted = False
        Exit Function
    End If
    If InStr(u.Title, "KB2483139") > 0 Then
        ' Language Packs
        update_is_wanted = False
        Exit Function
    End If
End Function

' Turn on Microsoft Update
Sub turn_on_microsoft_update
    Dim update_service_manager
    Set update_service_manager = CreateObject("Microsoft.Update.ServiceManager")

    Dim update_service
    Set update_service = update_service_manager.Services

    Dim need_to_register
    need_to_register = True

    If Err.Number <> 0 Then
        print_debug "Error turning on Microsoft Update", 10
        WScript.Quit(Err.Number)
    End If

    Dim service
    For Each service In update_service
        If service.ServiceID = "7971f918-a847-4430-9279-4a52d1efe18d" Then
            need_to_register = False
        End If
    Next    

    If need_to_register Then
        update_service_manager.AddService2 "7971f918-a847-4430-9279-4a52d1efe18d", 2, ""
    End If
End Sub

Sub print_debug(m, elapsed)
    If debug Then
        WScript.Echo m
    End If
    If task_sequence Then
        p.ShowActionProgress org_name, org_name, ts_name, step_name, step_num, max_step, m, elapsed, 10
        WScript.Sleep 500
    End If
End Sub
