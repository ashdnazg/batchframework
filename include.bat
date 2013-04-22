@ECHO off
SET LIBNAME=%~1
:Start
FOR /F %%A IN (%~1.bat) DO (
    CALL :ProcessLine "%%A"
)
GOTO :EOF

:ProcessLine
SET "LINE=%~1"
IF %LINE:~,1%==: 
    IF NOT %LINE:~1,1%==: (
        CALL SET "%LIBNAME%.%LINE:~1%=CALL %LIBNAME% %LINE:~1%"
    )
)
GOTO :EOF
