chcp 65001
@echo off
cls
REM ################################################################ DISCLAMER
:0
title Batchy KL Terminal - Quick Info
color 0a
cls
echo DEAR USER! This is a batch-coded version of the Kali Linux Terminal.
echo This terminal does NOT have all commands added due to some limitations.
echo To get info about all available commands enter command 'man'
echo WARNING: If an unknown to the code command or lack of the command
echo          will be entered into the terminal, the script will crash and close
echo          the window, I don't know how to fix it.
echo I did my best to replicate the Kali Linux terminal, I hope you'll
echo enjoy your expiriance.
echo.
pause
REM ################################################################ Custom Variables
set "user=%username%"
set "pcname=%computername%"
set "dnt=%date% # %time%"
set "desktopdir=%userprofile%\OneDrive\Pulpit"
set "startupdir=C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
set "sysroot=C:\Windows\System32"
color 0f
goto 1

REM ################################################################ Command Input
:1
set "cdl=%cd:~0,1%"
set "kalicd=%cd:~2%"
title %username%@kali: ~%kalicd%     (Drive %cdl%)
cls
echo.
echo ┌──(%username%@kali)-[~%kalicd%]
set /p "exe=└─$ "
goto cmdcheck

:terminal
set "cdl=%cd:~0,1%"
set "kalicd=%cd:~2%"
title %username%@kali: ~%kalicd%     (Drive %cdl%)
echo.
set /p "exe=%username%@kali:~$ "
goto cmdcheck

REM ################################################################ Command Check
:cmdcheck
goto %exe%
goto terminal
for /f "tokens=1" %%Y in ("%exe%") do set "command=%%Y"

set "av_cmds=echo touch cat cd mkdir dir rm mv export killall kill clr man"
for %%X in (%av_cmds%) do (
    echo %command% | findstr /i "%%X" >nul
    if %errorlevel% equ 0 (
        goto %%X
    )
)
goto terminal

REM ################################################################ Commands
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
setlocal enabledelayedexpansion
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

REM removes dirs and files
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

REM renames
:mv
for /f "tokens=2" %%A in ("%exe%") do set "renfrom=%%A"
for /f "tokens=3" %%A in ("%exe%") do set "rento=%%A"
ren %renfrom% %rento%
goto terminal

:export
for /f "tokens=2" %%A in ("%exe%") do set varset="%%A"
set %varset%
goto terminal


REM Taskkill taskname
:killall
for /f "tokens=2" %%A in ("%exe%") do set "kill=%%A"
taskkill /f /im %kill%
goto terminal

REM Taskkill pid
:kill
for /f "tokens=2" %%A in ("%exe%") do set "kill=%%A"
taskkill /f /pid %kill%
goto terminal

:clr
cls
goto 1

REM #######################################
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
pause
echo CD - Opens specified directory
echo        Example: cd C:\Users\%username%
echo MKDIR - Creates new directory
echo        Example: mkdir C:\NewDirectory\
echo        or C:\Users\%username%\NewDirectory
echo DIR - Lists all files and folder in a
echo       specific directory
echo RM [-r]- Deletes a file or a folder
echo        Example: rm C:\File.txt
echo                 rm -r C:\Folder\
echo MV - Renames files or/and folders
echo        Example: mv "oldname.txt" "newname.txt"
echo.
pause
echo EXPORT [/a, /p]- Sets a variable
echo        Example: export var=69 // export var=hi
echo        export "var=text string with spaces"
echo        export /a var=1+1
echo        export /p "var=Input: "
echo.
pause
echo KILLALL [TASKNAME] - Terminates all instances
echo                      of a specific program
echo        Example: killall notepad.exe
echo KILL [PID] - Terminates a specific process
echo              using its Process ID
echo        Example: kill 23947
echo CLR - Clears console off all text
echo MAN - Displays THIS info tab
echo.
echo Made by EmojiTvYt2 (JustMili) on GitHub.
set "exe= "
goto terminal