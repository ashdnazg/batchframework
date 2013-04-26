@ECHO off
:Start
CHOICE /C WASDQE > NUL 2>&1
IF %ERRORLEVEL%==5 (
    ECHO 1 >stop.tmp
    EXIT /b
)
IF %ERRORLEVEL%==6 ECHO.
(ECHO %ERRORLEVEL%) >input.tmp
GOTO :Start