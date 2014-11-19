' install adblock plus, by william jackson (w@utexas.edu)
' last edited 2011-11-08 for version 1.3.10

' this script will deploy adblock plus as a global extension
' for all users of firefox

' set up variables that may change with new versions of this script
str_program_name = "Adblock Plus"
str_adblock_folder = "{d10d0bf8-f5b5-c8b4-a8b2-2b9879e08c5d}"
str_firefox_folder = "mozilla firefox"

' set up constants and variables
set obj_shell = wscript.createobject("wscript.shell")
set obj_fso = createobject("scripting.filesystemobject")
str_current_dir = left(wscript.scriptfullname, (len(wscript.scriptfullname)) - (len(wscript.scriptname)))
str_log_prefix = wscript.scriptfullname & " : The " & str_program_name & " installation script "
str_adblock_source_path = str_current_dir + str_adblock_folder
str_programfiles = obj_shell.expandenvironmentstrings("%programfiles(x86)%")
if str_programfiles = "%programfiles(x86)%" then
  ' this is 32-bit
  str_programfiles = obj_shell.expandenvironmentstrings("%programfiles%")
else
  ' this is 64-bit
end if

str_firefox_extensions = str_programfiles & "\" & str_firefox_folder & "\extensions"
str_adblock_destination = str_firefox_extensions & "\" & str_adblock_folder

' announce start
obj_shell.logevent information, str_log_prefix & "has started."

' only continue if firefox is installed in the default location
str_firefox_folder = str_programfiles & "\" & str_firefox_folder
if obj_fso.folderexists(str_firefox_folder) then

  ' firefox is installed
  obj_shell.logevent information, str_log_prefix & "found Firefox installed at " & str_firefox_folder & " and will proceed with the installation."

  ' create the extensions folder if it doesn't exist
  if obj_fso.folderexists(str_firefox_extensions) then
    ' don't need to create the extensions folder
  else
    obj_fso.createfolder(str_firefox_extensions)
    obj_shell.logevent information, str_log_prefix & "created the folder " & str_firefox_extensions
  end if

  ' delete the adblock plus folder if it already exists (upgrading from a previous version)
  if obj_fso.folderexists(str_adblock_destination) then
    obj_shell.logevent information, str_log_prefix & "found a previous version of " & str_program_name & " and deleted it."
    obj_fso.deletefolder(str_adblock_destination)
  else
    ' don't need to delete existing adblock plus folder
  end if

  ' copy the adblock plus source files
  obj_fso.copyfolder str_adblock_source_path, str_firefox_extensions & "\"
  obj_shell.logevent information, str_log_prefix & "installed " & str_program_name & " into the following location: " & str_firefox_extensions & "\" & str_adblock_folder
else
  ' firefox is not installed
  obj_shell.logevent error, str_log_prefix & "did not find Firefox in the default location (" & str_firefox_folder & ") and cannoot proceed with the installation."
end if

' announce end
obj_shell.logevent information, str_log_prefix & "has ended."
