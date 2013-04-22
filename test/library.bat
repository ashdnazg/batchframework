@ECHO off
:Start
CALL :%*
GOTO :EOF

:Func1
ECHO Func1 was called
GOTO :EOF

:Func2
ECHO Func2 was called
GOTO :EOF