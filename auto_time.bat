::KhanhNguyen9872
@echo off
@setlocal enableextensions
@cd /d "%~dp0"
TITLE auto_time - KhanhNguyen9872
set count=1
GOTO check_Permissions

:check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    GOTO check_internet
) else (
    exit /b
)

:check_internet
ping google.com -n 1 -w 5000 >nul 2>&1
if %errorLevel% == 0 (
    GOTO HOME 
) else (
    timeout 15 >nul 2>&1
    GOTO check_internet
)

:HOME
.\KhanhNguyen9872\curl.exe -k -v --silent https://google.com 2> cache > NUL
.\KhanhNguyen9872\grep.exe "< date:" "cache" | .\KhanhNguyen9872\sed.exe "s/< date: //" > cache_
set /p datetime=<cache_
echo %datetime% | .\KhanhNguyen9872\awk.exe "{print $5}" > cache
set /p time=<cache
echo | date > cache
.\KhanhNguyen9872\grep.exe -a -m1 "dd" "cache" | .\KhanhNguyen9872\awk.exe "{print $5}" | .\KhanhNguyen9872\sed.exe "s/(//g" | .\KhanhNguyen9872\sed.exe "s/)//g" | .\KhanhNguyen9872\sed.exe "s/dd/ /g" | .\KhanhNguyen9872\sed.exe "s/mm/ /g" | .\KhanhNguyen9872\sed.exe "s/yy/ /g" | .\KhanhNguyen9872\awk.exe "{print $1}" > cache_
set /p khanh=<cache_
.\KhanhNguyen9872\grep.exe -a -m1 "dd" "cache" | .\KhanhNguyen9872\awk.exe "{print $5}" | .\KhanhNguyen9872\sed.exe "s/(//g" | .\KhanhNguyen9872\sed.exe "s/)//g" | .\KhanhNguyen9872\sed.exe "s/%khanh%/ /g" > cache_
set /p typedate=<cache_
echo %datetime% | .\KhanhNguyen9872\awk.exe "{$1=$5=$6=Khanh; print $0}" | .\KhanhNguyen9872\sed.exe "s/Khanh//g" | .\KhanhNguyen9872\sed.exe "s/Jan/\/01\//g" | .\KhanhNguyen9872\sed.exe "s/Feb/\/02\//g" | .\KhanhNguyen9872\sed.exe "s/Mar/\/03\//g" | .\KhanhNguyen9872\sed.exe "s/Apr/\/04\//g" | .\KhanhNguyen9872\sed.exe "s/May/\/05\//g" | .\KhanhNguyen9872\sed.exe "s/Jun/\/06\//g" | .\KhanhNguyen9872\sed.exe "s/Jul/\/07\//g" | .\KhanhNguyen9872\sed.exe "s/Aug/\/08\//g" | .\KhanhNguyen9872\sed.exe "s/Sep/\/09\//g" | .\KhanhNguyen9872\sed.exe "s/Oct/\/10\//g" | .\KhanhNguyen9872\sed.exe "s/Nov/\/11\//g" | .\KhanhNguyen9872\sed.exe "s/Dec/\/12\//g" | .\KhanhNguyen9872\sed.exe "s/ //g" | .\KhanhNguyen9872\sed.exe "s/\// /g" > cache
set /p date=<cache
tzutil.exe /g > cache 2> NUL
set /p current_utc=<cache
GOTO READ_DATE

:READ_DATE
echo %typedate% | .\KhanhNguyen9872\awk.exe "{print $%count%}" > cache_
set /p temp=<cache_
if %temp%==dd (set a=1)
if %temp%==mm (set a=2)
if %temp%==yy (set a=3)
echo %date% | .\KhanhNguyen9872\awk.exe "{print $%a%}" > cache_
set /p temp=<cache_
set final_date=%final_date% %temp%
set /a "count=%count%+1"
if %count%==4 (GOTO FINISH) else (GOTO READ_DATE)

:FINISH
echo %final_date% | .\KhanhNguyen9872\sed.exe "s/ /%khanh%/g" | .\KhanhNguyen9872\sed.exe "s/^.//" | .\KhanhNguyen9872\sed.exe "s/.$//" > cache
set /p date=<cache
del /f cache >nul 2>&1
del /f cache_ >nul 2>&1
tzutil.exe /s "Greenwich Standard Time"
date %date%
time %time%
tzutil.exe /s "%current_utc%"
echo CreateObject("WScript.Shell").Popup "Datetime has been edited successfully!", 11, "Auto Time | KhanhNguyen9872" > khanh.vbs
WScript .\khanh.vbs
del /f .\khanh.vbs
exit /b