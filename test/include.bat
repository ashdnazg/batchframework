::@ECHO off

:Start
SET "include.LIBNAME=%~1"
CALL %include.LIBNAME% Init

FOR /F %%A IN (%~1.bat) DO (
    CALL :ProcessLine "%%A"
)
GOTO :EOF

:ProcessLine
SET "include.processline.LINE=%~1"
IF %include.processline.LINE:~,1%_==:_ (
    IF NOT %include.processline.LINE:~1,1%_==:_ (
        CALL SET "%include.LIBNAME%.%include.processline.LINE:~1%=CALL %include.LIBNAME% %include.processline.LINE:~1%"
    )
)
GOTO :EOF
