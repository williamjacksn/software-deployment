' install jedit, by william jackson (w@utexas.edu)
' last edit 2010-10-14 for version 4.3.2

set obj_shell = wscript.createobject("wscript.shell")
int_install_result = obj_shell.run("jedit4.3.2install.exe /verysilent /norestart /mergetasks=""!desktopicon,!quicklaunchicon,!autostartserver""", 0, true)
