@echo off

:: Check for administrator rights
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: If errorlevel is not 0, we do not have admin rights
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    
    :: Use PowerShell to relaunch the script as admin
    powershell -Command "Start-Process '%0' -ArgumentList '%*' -Verb RunAs"
    
    :: Exit the current script instance
    exit /b
)

:: Commands to be run with elevated privileges
echo Running System File Checker...
sfc /scannow

echo Deleting all files in the Temp directory...
del /q/f/s %TEMP%\*

echo Upgrading all installed packages via Winget...
winget upgrade --all

echo All tasks have been completed successfully.

pause