::@ECHO off
:Start
CALL :%*
EXIT /b
:Init
CALL INCLUDE text
CALL INCLUDE list
IF "%RENDERER%" NEQ "1" (
    SET RENDERER=1
    %list.New% RENDERER.OBJECTS
    SET RENDERER.HEIGHT=20
    SET RENDERER.WIDTH=50
    SET "RENDERER.BLANKROW=                                                  "
)
EXIT /b

:Sprite <out_sprite> <file>
SET %~1.ROWS=0
FOR /F "delims=" %%A in (%~2)  DO (
    CALL SET "%~1[%%%~1.ROWS%%]=%%A"
    CALL :SpriteRow %~1[%%%~1.ROWS%%] "%%A"
    CALL SET /A %~1.ROWS=%%%~1.ROWS%%+1
)
EXIT /b

:SpriteRow out_row text
SETLOCAL DisableDelayedExpansion
SET "TEXT=%~2"
%@text.StrLen% LENTOTAL TEXT
FOR /F "delims=" %%T IN ('ECHO ^| SET /p .^="%~2"') DO (
    SET STRIPPED=%%T
    %@text.StrLen% LENSTRIPPED STRIPPED
)
ENDLOCAL & (
SET "%~1=%STRIPPED%"
SET /A %~1.START=%LENTOTAL%-%LENSTRIPPED%
SET /A %~1.LEN=%LENSTRIPPED%
)
EXIT /b

:Object <out_object> <sprite> <height> <width> <row> <col>
SET %~1.SPRITE=%~2
SET %~1.HEIGHT=%~3
SET %~1.WIDTH=%~4
SET %~1.ROW=%~5
SET %~1.COL=%~6
%list.Add% RENDERER.OBJECTS %~1
EXIT /b

:Render <file>
%@list.GetAll% RENDERER.OBJECTS OBJS
SETLOCAL EnableDelayedExpansion
FOR /L %%R in (0,1,%RENDERER.HEIGHT%) DO (
    SET "TEMPROW=%RENDERER.BLANKROW%
    FOR %%O in (%OBJS%) DO (
        SET /A Y=%%R - !%%O.ROW!
        SET SPRITE=!%%O.SPRITE!
        FOR %%S in (!SPRITE!) DO (SET SPRITEROWS=!%%S.ROWS!)
        IF !Y! GEQ 0 IF !SPRITEROWS! GTR !Y! FOR %%S in (!SPRITE!) DO FOR %%Y in (!Y!) DO (
            SET /A BEFORE=!%%S[%%Y].START! + !%%O.COL!
            SET /A AFTER=!BEFORE!+!%%S[%%Y].LEN!
            FOR %%B IN (!BEFORE!) DO FOR %%A IN (!AFTER!) DO SET "TEMPROW=!TEMPROW:~0,%%B!!%%S[%%Y]!!TEMPROW:~%%A!"
        )
    )
    ECHO.!TEMPROW!
)
ENDLOCAL
EXIT /b
