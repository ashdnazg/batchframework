@ECHO off
:Start
CALL :%*
EXIT /b
:Init
EXIT /b
:Wait
SET /A time.wait.TARGET=(%TIME:~-2,1% + %1) %% 10
:WaitLoop
SET /A time.wait.DIGIT=%TIME:~-2,1%
IF %time.wait.DIGIT% NEQ %time.wait.TARGET% GOTO :WaitLoop
EXIT /b
