@ECHO off
:Start
CALL :%*
EXIT /b
:Init
SET time.wait.TARGET=NONE
EXIT /b
:Wait
IF %time.wait.TARGET%==NONE SET /A time.wait.TARGET=(1%TIME:~-2,2% + %1) %% 100
:WaitLoop
SET /A time.wait.DELTA=(1%TIME:~-2,2% - %time.wait.TARGET%) %% 100
ECHO IF %time.wait.DELTA% GTR %1 GOTO :WaitLoop
SET /A time.wait.TARGET+=%1
EXIT /b
