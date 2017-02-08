@echo off
setlocal EnableDelayedExpansion

set this_path=%~dp0
start "" /D "!this_path!src\" replace-text.ahk
if errorlevel 1 start "" /D "!this_path!src\" replace-text.exe
@echo on