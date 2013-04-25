@ECHO off
:Start
CHOICE /C WASDQ > NUL
(ECHO %ERRORLEVEL%) >input.tmp
IF %ERRORLEVEL%==5 EXIT /b
GOTO :Start