@echo off
setlocal EnableDelayedExpansion EnableExtensions

set this_path=%~dp0
set shortcut_script=create_shortcut.vbs
set desktop_script=get_desktop.vbs
set link_name=replace-text.lnk
cd /d "!this_path!"
cd src

(
	echo:Set WshShell = WScript.CreateObject("WScript.Shell"^)
	echo:Set oShortcut = WshShell.CreateShortcut("!link_name!"^)
	echo:oShortcut.WindowStyle = "1"
	echo:oShortcut.TargetPath = "!this_path!\enable_replacements.cmd"
	echo:oShortcut.WorkingDirectory = "!this_path!"
	echo:oShortcut.IconLocation = "!this_path!\icon\ahk.ico"
	echo:oShortcut.Save
) >!shortcut_script!

cscript !shortcut_script!

del !shortcut_script!

(
	echo:dim WSHShell, desktop, pathstring, objFSO
	echo:Set WSHshell = CreateObject("WScript.Shell"^)
	echo:desktop = WSHShell.SpecialFolders("Desktop"^)
	echo:set objFSO=CreateObject("Scripting.FileSystemObject"^)
	echo:pathstring = objFSO.GetAbsolutePathName(desktop^)
	echo:WScript.Echo pathstring
) >!desktop_script!

FOR /F "usebackq delims=" %%i in (`cscript "!this_path!\src\!desktop_script!"`) DO SET desktop_dir=%%i

del !desktop_script!

move /y !link_name! "!desktop_dir!"

@echo on