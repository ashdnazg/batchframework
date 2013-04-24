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
SET /A time.wait.DIGIT=1%TIME:~-2,2% %% 100
IF %time.wait.DIGIT% NEQ %time.wait.TARGET% GOTO :WaitLoop
SET /A time.wait.TARGET=(%time.wait.TARGET% + %1) %% 100
EXIT /b
