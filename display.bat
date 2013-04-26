@ECHO off
CALL INCLUDE timeops
:Start
IF EXIST lock.tmp (
    CLS
    TYPE display.tmp
    DEL lock.tmp > NUL 2>&1
)
REM %timeops.Wait% 8
IF NOT EXIST stop.tmp GOTO :Start
