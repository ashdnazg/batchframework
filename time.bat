::@ECHO off
:Start
CALL :%*
GOTO :EOF
:Init
GOTO :EOF
:Wait
SET /A time.wait.TARGET=(%TIME:~-2,1% + %1) %% 10
:WaitLoop
SET /A time.wait.DIGIT=%TIME:~-2,1%
IF %time.wait.DIGIT% NEQ %time.wait.TARGET% GOTO :WaitLoop
GOTO :EOF
