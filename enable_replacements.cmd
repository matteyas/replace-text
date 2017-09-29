@echo off
setlocal EnableDelayedExpansion

set this_path=%~dp0
cd /d !this_path!

if not exist firstrun.z (
  choice /M "Do you currently have AutoHotkey installed? (delete firstrun.z to configure this again)"
  if errorlevel 2 (set ext=.exe)
  if errorlevel 1 (set ext=.ahk)
  echo !ext!>firstrun.z
) else (
  set /p ext=<firstrun.z
)

start "" /D "!this_path!src\" replace-text!ext!
@echo on