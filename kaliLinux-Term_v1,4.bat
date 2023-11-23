chcp 65001
setlocal enabledelayedexpansion
mode con: cols=135 lines=30
@echo off
cls

REM ################################################################ Custom Variables
set "desktopdir=MISSING_DIR"
set "startupdir=C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
set "sysroot=C:\Windows\System32"
set "DownloadsDir=C:\Users\%username%\Downloads"

REM ################################################################ Command Input
:1
set exe=
set "cdl=%cd:~0,1%"
set "kalicd=%cd:~2%"
title %username%@kali: ~%kalicd%     (Drive %cdl%)
cls
echo.
echo ┌──(%username%@kali)-[~%kalicd%]
set /p "exe=└─$ "
goto cmdcheck

:terminal
set exe=
set "cdl=%cd:~0,1%"
set "kalicd=%cd:~2%"
title %username%@kali: ~%kalicd%     (Drive %cdl%)
echo.
set /p "exe=%username%@kali:~$ "
goto cmdcheck
:cmdcheck
for /f "tokens=1" %%Y in ("!exe!") do set "command=%%Y"
set "av_cmds=echo touch cat cd mkdir dir rm mv git export killall kill clear man explorer calc notepad charmap cmd regedit gpedit control chrome firefox brave operagx steam cal whoami pwd history"
set "kcmd_detected="
set "cmd_hist=%cmd_hist% %exe%"
for %%X in (%av_cmds%) do (
    echo !command! | findstr /i "%%X" >nul
    if !errorlevel! equ 0 (
        set "kcmd_detected=1"
        goto %%X
    )
)
if not defined kcmd_detected (
    echo bash: %exe%: command not found
    goto terminal
)
goto terminal

REM ################################################################ Commands: Commands
:echo
for /f "tokens=2" %%A in ("%exe%") do set "text=%%A"
for /f "tokens=3" %%A in ("%exe%") do set "savefile=%%A"
echo %text% %savefile%
goto terminal

:touch
for /f "tokens=2" %%A in ("%exe%") do set "file=%%A"
echo . >%file%
goto terminal

:cat
for /f "tokens=2" %%A in ("%exe%") do set "file=%%A"
type %file%
goto terminal

:cd
for /f "tokens=2" %%A in ("%exe%") do set "newpath=%%A"
cd /D %newpath%
goto terminal

:mkdir
for /f "tokens=2" %%A in ("%exe%") do set "newfolder=%%A"
md %newfolder%
goto terminal

:dir
set "output="
for /d %%i in (*) do (
    set "output=!output! %%i "
)
echo.
echo.
echo.
for %%i in (*.*) do (
    set "output=!output! %%i "
)
echo %output%
endlocal
goto terminal

:rm
for /f "tokens=3" %%A in ("%exe%") do set "ifdelfolder=%%A"
if %ifdelfolder%==-r (
    for /f "tokens=2" %%A in ("%exe%") do set "todelete=%%A"
    del %todelete%
) else (
    for /f "tokens=2" %%A in ("%exe%") do set "todelete=%%A"
    del %todelete%
)
goto terminal

:mv
for /f "tokens=2" %%A in ("%exe%") do set "renfrom=%%A"
for /f "tokens=3" %%A in ("%exe%") do set "rento=%%A"
ren %renfrom% %rento%
goto terminal
:export

for /f "tokens=2" %%A in ("%exe%") do set varset="%%A"
set %varset%
goto terminal

:git
mode con: cols=135 lines=50
for /f "tokens=2" %%A in ("%exe%") do set "ifclone=%%A"

if not defined ifclone (
    echo bash: git %ifclone%: command not found.
    goto terminal
) 
if not %ifclone%==clone (
    echo bash: git %ifclone%: command not found.
    set ifclone=
    goto terminal
) 
if %ifclone%==clone (
    for /f "tokens=3" %%A in ("%exe%") do set "repoUrl=%%A"
    set "repoUrl=!repourl!/archive/refs/heads/main.zip"
    echo Cloning to '!DownloadDir!'...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('!repoUrl!','%DownloadsDir%main.zip')"
    mode con: cols=135 lines=30
    echo Unpacking
    powershell -Command "Expand-Archive -Path '%DownloadsDir%main.zip' -DestinationPath '%DownloadsDir%' -Force"
    echo.
    echo Repository downloaded successfully to %DownloadsDir%.
    del %DownloadsDir%main.zip
)
goto terminal

:killall
for /f "tokens=2" %%A in ("%exe%") do set "kill=%%A"
taskkill /f /im %kill%
goto terminal
:kill
for /f "tokens=2" %%A in ("%exe%") do set "kill=%%A"
taskkill /f /pid %kill%
goto terminal

:clear
cls
goto 1

:man
echo.
echo Batchy Kali Linux - Terminal Commands
echo.
echo ECHO - Display text in terminal
echo        Write to file (Has troubles saving text)
echo        USE LIKE IN BATCH!!
echo TOUCH - Create empty file
echo        Example: touch file.txt
echo CAT -  Read from file
echo        Example: cat file.txt
echo.
pause >nul
REM #######################################
echo CD - Opens specified directory
echo        Example: cd C:\Users\%username%
echo MKDIR - Creates new directory
echo        Example: mkdir C:\NewDirectory\
echo        or C:\Users\%username%\NewDirectory
echo DIR - Lists all files and folder in a
echo       specific directory
echo RM [-r] - Deletes a file or a folder
echo         Example: rm C:\File.txt
echo                 rm -r C:\Folder\
echo MV - Renames files or/and folders
echo        Example: mv "oldname.txt" "newname.txt"
echo.
pause >nul
REM #######################################
echo GIT [CLONE] - Download Github projects
echo             Example:
echo             git clone [REPO LINK]
echo             Example Repository Link:
echo         https://github.com/EmojiTvYt2/BatchyKL-Terminal
echo.
pause >nul
REM #######################################
echo EXPORT [/a, /p]- Sets a variable
echo        Example: export var=69 // export var=hi
echo        export "var=text string with spaces"
echo.
pause >nul
REM #######################################
echo KILLALL [TASKNAME] - Terminates all instances
echo                      of a specific program
echo        Example: killall notepad.exe
echo KILL [PID] - Terminates a specific process
echo              using its Process ID
echo        Example: kill 23947
echo CLEAR - Clears console off all text
echo MAN - Displays THIS info tab
echo.
pause >nul
echo [APPNAME] - Starts the specified program.
echo           Available programs: explorer, calc, notepad,
echo           charmap, cmd, regedit, gpedit, control,
echo           chrome, firefox, brave, operagx, steam,
echo.
pause >nul
REM #######################################
echo CAL - Displays current date
echo WHOAMI - Displays information about current user
echo PWD - Displays currently opened directory
echo HISTORY - Displays all prevously used commands
echo.
echo Made by EmojiTvYt2 (JustMili) on GitHub.
set exe=
goto terminal

:cal
set "year=%date:~10%"
set "month=%date:~4,2%"
set "days=%date:~7,2%"
if %month%==01 set disp_month=January
if %month%==02 set disp_month=Febuary
if %month%==03 set disp_month=March
if %month%==04 set disp_month=April
if %month%==05 set disp_month=May
if %month%==06 set disp_month=June
if %month%==07 set disp_month=July
if %month%==08 set disp_month=August
if %month%==09 set disp_month=September
if %month%==10 set disp_month=October
if %month%==11 set disp_month=November
if %month%==12 set disp_month=December
echo     %disp_month% %year%
echo     %days%
goto terminal

:whoami
echo %username%
goto terminal

:pwd
echo  %cd%
echo  %kalicd%
goto terminal

:history
set "lineNumber=0"
set "concatCommand="
for %%i in (%cmd_hist%) do (
    set /a "lineNumber+=1"
    if defined concatCommand (
        echo !lineNumber! !concatCommand! %%i
        set "concatCommand="
    ) else if /i "%%i"=="echo" (
        set "concatCommand=%%i "
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="cat" (
        set "concatCommand=%%i "
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="touch" (
        set "concatCommand=%%i "
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="cd" (
        set "concatCommand=%%i "
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="kill" (
        set "concatCommand=%%i "
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="killall" (
        set "concatCommand=%%i "
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="git" (
        set "concatCommand=%%i "
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="rm" (
        set "concatCommand=%%i "
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="mkdir" (
        set "concatCommand=%%i "
        set /a "lineNumber-=1"
    ) else if /i "%%i"=="mv" (
        set "concatCommand=%%i "
        set /a "lineNumber-=1"
    ) else (
        echo !lineNumber! %%i
    )
)
goto terminal

REM ################################################################ Commands: Apps
:explorer
explorer
goto terminal 
:calc
calc
goto terminal
:notepad
notepad
goto terminal
:charmap
charmap
goto terminal
:cmd
start
goto terminal
:regedit
regedit
goto terminal
:gpedit
gpedit
goto terminal
:control
control
goto terminal
:chrome
set "prevcd=%cd%"
cd /D "C:\Program Files\Google\Chrome\Application\"
start chrome.exe
cd /D %prevcd%
goto terminal
:firefox
set "prevcd=%cd%"
cd /D "C:\Program Files\Mozilla Firefox\"
start firefox.exe
cd /D %prevcd%
goto terminal
:brave
set "prevcd=%cd%"
cd /D "C:\Program Files\BraveSoftware\Brave-Browser\Application\"
start brave.exe
cd /D %prevcd%
goto terminal
:operagx
set "prevcd=%cd%"
cd /D "C:\Users\%username%\AppData\Local\Programs\Opera GX\"
start opera.exe
cd /D %prevcd%
goto terminal
:steam
set "prevcd=%cd%"
cd /D "C:\Program Files (x86)\Steam\"
start steam.exe
cd /D %prevcd%
goto terminal
