@echo off
REM BatchyKL - Made By EmojiTvYt2 on GitHub (Aka justmili_ on Discord)
REM https://github.com/EmojiTvYt2/BatchyKL-Terminal/
title Loading Terminal
:load
echo.
echo   ______     ______     ______   ______     __  __     __  __     __  __     __
echo  /\  == \   /\  __ \   /\__  _\ /\  ___\   /\ \_\ \   /\ \_\ \   /\ \/ /    /\ \
echo  \ \  __ (  \ \  __ \  \/_/\ \/ \ \ \____  \ \  __ \  \ \____ \  \ \  _\"-.  \ \ \____
echo   \ \_____\  \ \_\ \_\    \ \_\  \ \_____\  \ \_\ \_\  \/\_____\  \ \_\ \_\  \ \______\
echo    \/_____/   \/_/\/_/     \/_/   \/_____/   \/_/\/_/   \/_____/   \/_/\/_/   \/______/
echo                                        Loading...
REM ################################################################ Variables
set "bklHFN=BatchyKL_history.data.dll"
set "sysroot=C:\Windows\"
set "root=C:\"
set "home=C:%homepath%\"
set "DownloadsDir=C:\Users\%username%\Downloads"
set "cmd_user=man whoami clear history cal"
set "cmd_dirs=cd mkdir ls rm mv git pwd"
set "cmd_files=echo touch cat"
set "cmd_tasks=killall kill"
set "cmd_apps=explorer calc notepad charmap cmd regedit gpedit msconfig control chrome firefox brave operagx steam"
set "cmds=%cmd_user% %cmd_dirs% %cmd_files% %cmd_tasks% %cmd_apps%"
set "man_programs=%cmd_apps%"
set "man_cmds=%cmd_user% %cmd_dirs% %cmd_files% %cmd_tasks%"
REM --------------------------------------------------------
if not exist "C:\BatchyKL\" (
    md "C:\BatchyKL\"
)
cd /D "C:\BatchyKL\"
(
set /p "cmd_hist="
)<%bklHFN%
cd /D %home%
chcp 65001
echo (That's to display ┌── and └─)
setlocal enabledelayedexpansion
REM --------------------------------------------------------
timeout /t 2 /nobreak >nul
mode con: cols=86 lines=36
cls
goto 1

REM ################################################################ Command Input
:1
REM Path check, if C:\ set to /, if %homepath% set to ~.
set "kalicd=%cd:~2%"
set "cdl=%cd:~0,1%"
if %cd%\==C:%homepath%\ (
    set "dirdisp=~"
    goto terminal
) else (
    if %cd%==C:\ (
        set "dirdisp=/"
        goto terminal
    ) else (
        set "dirdip=%kalicd%"
        goto terminal
    )
)
:terminal
set "exe="
title %username%@kali: %dirdisp%     (Drive %cdl%)
echo.
echo ┌──(%username%@kali)-[%dirdisp%]
set /p "exe=└─$ "
goto cmdcheck
REM ################################################################ Command Recognition
:cmdcheck
for /f "tokens=1" %%Y in ("!exe!") do set "command=%%Y"

set "kcmd_detected="

REM Command History write to file
set "cmd_hist=%cmd_hist% %exe%"
set "prevcd=%cd%"
cd /D "C:\BatchyKL\"
echo %cmd_hist% >%bklHFN%
cd /D %prevcd%

for %%X in (%cmds%) do (
    echo !command! | findstr /i "%%X" >nul
    if !errorlevel! equ 0 (
        set "kcmd_detected=1"
        goto %%X
    )
)
if not defined kcmd_detected (
    echo bash: %exe%: command not found
    goto 1
)
goto 1

REM ################################################################ Commands: Commands
:echo
for /f "tokens=2" %%A in ("%exe%") do set "text=%%A"
for /f "tokens=3" %%A in ("%exe%") do set "savefile=%%A"
echo %text% %savefile%
goto 1
::-------------------------------------------------------------------------------------
:touch
for /f "tokens=2" %%A in ("%exe%") do set "file=%%A"
echo . >%file%
goto 1
::-------------------------------------------------------------------------------------
:cat
for /f "tokens=2" %%A in ("%exe%") do set "file=%%A"
type %file%
goto 1
::-------------------------------------------------------------------------------------
:cd
for /f "tokens=2" %%A in ("%exe%") do set "newpath=%%A"
cd /D %newpath%
goto 1
::-------------------------------------------------------------------------------------
:mkdir
for /f "tokens=2" %%A in ("%exe%") do set "newfolder=%%A"
md %newfolder%
goto 1
::-------------------------------------------------------------------------------------
:ls
set "output="
for /d %%i in (*) do (
    set "output=!output! %%i "
)
echo.
echo.
for %%i in (*.*) do (
    set "output=!output! %%i "
)
echo %output%
set "output="
goto 1
::-------------------------------------------------------------------------------------
:rm
for /f "tokens=2" %%A in ("%exe%") do set "if_r=%%A"
if %if_r%==-r (
    for /f "tokens=3" %%A in ("%exe%") do set "todelete=%%A"
    del %todelete%
) else (
    for /f "tokens=2" %%A in ("%exe%") do set "todelete=%%A"
    del %todelete%
)
goto 1
::-------------------------------------------------------------------------------------
:mv
for /f "tokens=2" %%A in ("%exe%") do set "renfrom=%%A"
for /f "tokens=3" %%A in ("%exe%") do set "rento=%%A"
ren %renfrom% %rento%
goto 1
::-------------------------------------------------------------------------------------
:export
for /f "tokens=2" %%A in ("%exe%") do set varset="%%A"
set %varset%
goto 1
::-------------------------------------------------------------------------------------
:git
for /f "tokens=2" %%A in ("%exe%") do set "ifclone=%%A"

if not defined ifclone (
    echo bash: git %ifclone%: command not found.
    goto 1
) 
if not %ifclone%==clone (
    echo bash: git %ifclone%: command not found.
    set ifclone=
    goto 1
) 
if %ifclone%==clone (
    for /f "tokens=3" %%A in ("%exe%") do set "repoUrl=%%A"
    set "repoUrl=!repourl!/archive/refs/heads/main.zip"
    echo Cloning to '!DownloadsDir!'...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('!repoUrl!','%DownloadsDir%main.zip')"
    echo Unpacking
    powershell -Command "Expand-Archive -Path '%DownloadsDir%main.zip' -DestinationPath '%DownloadsDir%' -Force"
    echo.
    echo Repository downloaded successfully to %DownloadsDir%.
    del %DownloadsDir%main.zip
)
goto 1
::-------------------------------------------------------------------------------------
:killall
for /f "tokens=2" %%A in ("%exe%") do set "kill=%%A"
taskkill /f /im %kill%
goto 1
:kill
for /f "tokens=2" %%A in ("%exe%") do set "kill=%%A"
taskkill /f /pid %kill%
goto 1
::-------------------------------------------------------------------------------------
:clear
cls
goto 1
::-------------------------------------------------------------------------------------
:man
set "man="
set "manfound="
for /f "tokens=2" %%A in ("%exe%") do set "man=%%A"
for %%X in (%man_programs%) do (
    if /i "!man!"=="%%X" (
        set "manfound=1"
        start www.github.com/EmojiTvYt2/BatchyKL-Terminal/tree/main/manual/command_manuals/manual_programs.txt
        goto 1
    )
)
for %%X in (%man_cmds%) do (
    if /i "!man!"=="%%X" (
        set "manfound=1"
        start www.github.com/EmojiTvYt2/BatchyKL-Terminal/tree/main/manual/command_manuals/manual_%man%.txt
        goto 1
    )
)
if not defined manfound (
    if not defined man (
        echo What manual page do you want?
        echo For example, try 'man man'
        set "exe="
        goto 1
    ) else (
        echo No manual entry for %man%
        set "exe="
        goto 1
    )
)
set "exe="
goto 1
::-------------------------------------------------------------------------------------
:cal
set "year=%date:~10%"
set "month=%date:~4,2%"
set "day=%date:~7,2%"
if %month%==01 set month=January
if %month%==02 set month=Febuary
if %month%==03 set month=March
if %month%==04 set month=April
if %month%==05 set month=May
if %month%==06 set month=June
if %month%==07 set month=July
if %month%==08 set month=August
if %month%==09 set month=September
if %month%==10 set month=October
if %month%==11 set month=November
if %month%==12 set month=December
echo     %month% %year%
echo     %day%
goto 1
::-------------------------------------------------------------------------------------
:whoami
echo %username%
goto 1
::-------------------------------------------------------------------------------------
:pwd
echo  %cd%
echo  %kalicd%
goto 1
::-------------------------------------------------------------------------------------
:history
set "lineNumber=0"
set "concatCommand="
for %%i in (%cmd_hist%) do (
    set /a "lineNumber+=1"
    if defined concatCommand (
        echo !lineNumber! !concatCommand! %%i
        set "concatCommand="
    ) else if /i "%%i"=="echo" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="cat" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="touch" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="man" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="cd" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="kill" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="killall" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="git" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="rm -r" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="rm" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="mkdir" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="mv" (
        set "concatCommand=%%i"
        set /a "lineNumber-=1"
    ) else (
        echo !lineNumber! %%i
    )
)
goto 1
::-------------------------------------------------------------------------------------
REM ################################################################ Commands: Apps
:explorer
explorer
goto 1 
:calc
calc
goto 1
:notepad
notepad
goto 1
:charmap
charmap
goto 1
:cmd
call cmd
goto 1
:regedit
regedit
goto 1
:gpedit
gpedit
goto 1
:msconfig
msconfig
goto 1
:control
control
goto 1
:chrome
set "prevcd=%cd%"
cd /D "C:\Program Files\Google\Chrome\Application\"
start chrome.exe
cd /D %prevcd%
goto 1
:firefox
set "prevcd=%cd%"
cd /D "C:\Program Files\Mozilla Firefox\"
start firefox.exe
cd /D %prevcd%
goto 1
:brave
set "prevcd=%cd%"
cd /D "C:\Program Files\BraveSoftware\Brave-Browser\Application\"
start brave.exe
cd /D %prevcd%
goto 1
:operagx
set "prevcd=%cd%"
cd /D "C:\Users\%username%\AppData\Local\Programs\Opera GX\"
start opera.exe
cd /D %prevcd%
goto 1
:steam
set "prevcd=%cd%"
cd /D "C:\Program Files (x86)\Steam\"
start steam.exe
cd /D %prevcd%
goto 1
::-------------------------------------------------------------------------------------