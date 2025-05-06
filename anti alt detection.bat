@echo off
cls
echo LOADING...
echo loaded
color A

title universal spoofer - Initializing...
title @5pect - Initialized

net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

set "clearFiles=C:\Users\%username%\AppData\Local\Temp"

setlocal enabledelayedexpansion
if exist "%clearFiles%" (
    del /f /q "%clearFiles%\*" >nul 2>&1
)
endlocal

set "deleteFolders=""
set "deleteFolders=%deleteFolders% C:\Users\%username%\AppData\Local\Temp\Roblox"
set "deleteFolders=%deleteFolders% C:\Users\%username%\AppData\Local\Roblox"
set "deleteFolders=%deleteFolders% C:\Users\%username%\AppData\Local\Bloxstrap"

setlocal enabledelayedexpansion
for %%F in (%deleteFolders%) do (
    if exist "%%F" (
        rd /s /q "%%F" >nul 2>&1
    )
)
endlocal

setlocal enabledelayedexpansion
set /a rand1=%random% %% 1000
set /a rand2=%random% %% 1000
set /a rand3=%random% %% 10000
set /a randLetter=%random% %% 26 + 65
for /f %%A in ('cmd /c exit !randLetter!') do set "randomChar=%%A"

echo spoofed-!rand1!!rand2!!rand3!!randomChar!
endlocal

choice /c YN /n /t 5 /d N /m "Do you want to restart your computer now? (Y/N)"
if %errorlevel%==1 (
    shutdown /r /f /t 5
)

pause
exit /b
