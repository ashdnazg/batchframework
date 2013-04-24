@ECHO off
CALL INCLUDE time
:Start
CLS
TYPE page1.txt
::CALL ECHO %BUF2%
%time.Wait% 1
CLS
TYPE page2.txt
::CALL ECHO %BUF1%
%time.Wait% 1
GOTO :Start
