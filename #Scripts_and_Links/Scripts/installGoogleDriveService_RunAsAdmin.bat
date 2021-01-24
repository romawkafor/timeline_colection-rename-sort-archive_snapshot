:: 1) Download srvany.exe from Microsoft Windows 2003 Resource Kit (available free from Microsoft). 
:: 2) Copy srvany.exe into the folder where google drive is installed or next to this script file.
:: 3) Run this script as an Administrator

echo off
cls

SET STARTING_DIR=%CD%
SET SCRIPT_DIR=%~dp0

echo Running from: %STARTING_DIR%
echo Script Dir: %SCRIPT_DIR%

SET DEFAULT_USERNAME=%USERDOMAIN%\%USERNAME%
SET /P UNAME=Enter username for account to run service under. (%DEFAULT_USERNAME%) || SET UNAME=%DEFAULT_USERNAME%
SET /P PWORD=Enter %UNAME% password. || Set PWORD=NothingChosen

If "%PWORD%"=="NothingChosen" goto :sub_error_nopass

echo Copying srvany.exe to C:\Program Files\Google\Drive
copy %SCRIPT_DIR%\srvany.exe "C:\Program Files\Google\Drive"

echo Adding Google Drive as a service...
echo sc create GoogleDriveSync displayName= "Google Drive Service" start= auto obj= "%UNAME%" password= %PWORD% binPath= "C:\Program Files\Google\Drive\srvany.exe"
sc create GoogleDriveSync displayName= "Google Drive Service" start= auto obj= "%UNAME%" password= %PWORD% binPath= "C:\Program Files\Google\Drive\srvany.exe"

echo Updating registry for service...
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GoogleDriveSync\Parameters /f
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GoogleDriveSync\Parameters /v Application /d "C:\Program Files\Google\Drive\googledrivesync.exe" /f
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GoogleDriveSync\Parameters /v AppParameters /d "/autostart --noshow_confirmation_dialog_on_delete" /f

echo Starting service...
net start GoogleDriveSync 


echo Finished.
pause
goto:eof


:sub_error_nopass
echo No password given. Ending.