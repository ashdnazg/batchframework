::@ECHO off
:Start
CALL :%*
EXIT /b
:Init
CALL INCLUDE text
CALL INCLUDE list
SET RENDERER=1
%@list.New% RENDERER.OBJECTS
SET RENDERER.HEIGHT=22
SET RENDERER.WIDTH=50
SET "RENDERER.BLANKROW=                                                  "
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

:Object <out_object> <sprite> <row> <col>
SET %~1.SPRITE=%~2
SET %~1.ROW=%~3
SET %~1.COL=%~4
%@list.Add% RENDERER.OBJECTS %~1
EXIT /b

:Render <objects> <start_line> <end_line>
SETLOCAL EnableDelayedExpansion
FOR /L %%R in (%~2,1,%~3) DO (
    SET "TEMPROW=%RENDERER.BLANKROW%
    FOR %%O in (!%1!) DO (
        SET /A Y=%%R - !%%O.ROW!
        SET SPRITE=!%%O.SPRITE!
        FOR %%S in (!SPRITE!) DO (SET SPRITEROWS=!%%S.ROWS!)
        IF !Y! GEQ 0 IF !SPRITEROWS! GTR !Y! FOR %%S in (!SPRITE!) DO FOR %%Y in (!Y!) DO (
            SET /A BEFORE=!%%S[%%Y].START! + !%%O.COL!
            IF !BEFORE! GEQ 0 (
                SET START=0
                SET /A AFTER=!BEFORE!+!%%S[%%Y].LEN!
                IF !AFTER! GTR %RENDERER.WIDTH% (
                    SET /A LEN=%RENDERER.WIDTH%-!BEFORE!
                    IF 0 GTR !LEN! SET LEN=0
                    SET AFTER=%RENDERER.WIDTH%
                ) ELSE SET LEN=!%%S[%%Y].LEN!
            ) ELSE (
                SET /A START=0 - !BEFORE!
                SET /A BEFORE=0
                SET /A LEN=!%%S[%%Y].LEN!-!START!
                IF 0 GTR !LEN! SET LEN=0
                SET /A AFTER=!BEFORE!+!LEN!
                IF !AFTER! GTR %RENDERER.WIDTH% (
                    SET /A LEN=%RENDERER.WIDTH%-!BEFORE!
                    IF 0 GTR !LEN! SET LEN=0
                    SET AFTER=%RENDERER.WIDTH%
                ) ELSE SET LEN=!%%S[%%Y].LEN!
            )
            FOR %%B IN (!BEFORE!) DO FOR %%A IN (!AFTER!) DO FOR %%T IN (!START!) DO FOR %%L IN (!LEN!) DO SET "TEMPROW=!TEMPROW:~0,%%B!!%%S[%%Y]:~%%T,%%L!!!TEMPROW:~%%A!"
        )
    )
    ECHO,!TEMPROW!
)
ENDLOCAL
EXIT /b
