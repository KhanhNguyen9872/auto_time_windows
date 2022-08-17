::KhanhNguyen9872
@echo off
color 71
@setlocal enableextensions
@cd /d "%~dp0"
TITLE Install auto_time - KhanhNguyen9872
GOTO check_windows

:check_windows
ver | .\KhanhNguyen9872\awk.exe "{print $4}" | .\KhanhNguyen9872\sed.exe "s/\./ /g" | .\KhanhNguyen9872\awk.exe "{print $1,$2}" | .\KhanhNguyen9872\sed.exe "s/ /./g" | .\KhanhNguyen9872\sed.exe "1d" > cache
set /p version=<cache
del /f cache >nul 2>&1
if "%version%" == "10.0" (echo Windows 10) else (if "%version%" == "6.3" (echo Windows 8.1) else (if "%version%" == "6.2" (echo Windows 8) else (if "%version%" == "6.2" (echo Windows 8) else (if "%version%" == "6.1" (echo Windows 7) else (
		echo Unsupported: Windows %version%
		pause
		exit /b)))))
GOTO check_Permissions

:check_Permissions
sc.exe config LanmanServer start=auto >nul 2>&1
sc.exe config W32Time start=auto >nul 2>&1
sc.exe start LanmanServer >nul 2>&1
sc.exe start W32Time >nul 2>&1
net session >nul 2>&1
if %errorLevel% == 0 (
    GOTO INSTALL
) else (
    echo Please run as administrator
    pause
    exit /b
)

:INSTALL
set PATH_INSTALL=%windir%\AutoTime
rmdir /q /s %PATH_INSTALL% >nul 2>&1
if not exist "%PATH_INSTALL%" (
	mkdir %PATH_INSTALL% >nul 2>&1
	mkdir %PATH_INSTALL%\KhanhNguyen9872 >nul 2>&1
)
copy /Y ".\KhanhNguyen9872\*.*" "%PATH_INSTALL%\KhanhNguyen9872" >nul 2>&1
copy /Y ".\auto_time.exe" "%PATH_INSTALL%" >nul 2>&1
echo Set WshShell = CreateObject("WScript.Shell" ) > "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\auto_time.vbs"
echo WshShell.Run """%PATH_INSTALL%\auto_time.exe""", 0 >> "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\auto_time.vbs"
echo Set WshShell = Nothing >> "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\auto_time.vbs"
reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f >nul 2>&1
GOTO ASK

:ASK
echo.
echo Install completed!
echo Do you want to start it now?
echo.
SET /P AREYOUSURE=Are you sure (Y/N): 
IF /I "%AREYOUSURE%" == "Y" GOTO RUN_SERVICE
IF /I "%AREYOUSURE%" == "y" GOTO RUN_SERVICE
exit /b

:RUN_SERVICE
echo.
echo Please wait...
echo.
%PATH_INSTALL%\auto_time.exe
exit /b
