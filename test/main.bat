@ECHO off
SETLOCAL
CALL INCLUDE library
CALL INCLUDE text
%library.Func1%

SET temp=aaa%%text.NL%%bbb
CALL ECHO %temp%
%text.StrLen% out_len
ECHO %out_len%
ENDLOCAL