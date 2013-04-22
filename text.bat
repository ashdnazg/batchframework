::@ECHO off
:Start
CALL :%*
GOTO :EOF

:Init
SET text.NLM=^


SET text.NL=^^^%text.NLM%%text.NLM%^%text.NLM%%text.NLM%
GOTO :EOF

:StrLen <stringVar> <resultVar>
SET "text.strlen.s=%~1#"
SET "text.strlen.len=0"
FOR %%P IN (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) DO (
    CALL :StrLenStep %%P
)
SET "%~2=%text.strlen.len%"
GOTO :EOF

:StrLenStep
CALL SET text.strlenstep.TEMP=%%text.strlen.s:~%1,1%%
IF "%text.strlenstep.TEMP%" NEQ "" ( 
        SET /a "text.strlen.len+=%1"
        CALL SET "text.strlen.s=%%text.strlen.s:~%1%%"
)
GOTO :EOF