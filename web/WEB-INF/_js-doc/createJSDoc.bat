@echo off

SET TEMPLATE=.\npm\node_modules\ink-docstrap\template
PUSHD %TEMPLATE%
SET TEMPLATE=%CD%
POPD
echo Template path is %TEMPLATE%

SET CONFIG=.
PUSHD %CONFIG%
SET CONFIG=%CD%\jsdoc.conf.json
POPD
echo Config is located at %CONFIG%

SET OUTPUT_DIR=.\out
IF NOT EXIST "%OUTPUT_DIR%" (
    echo "Making %OUTPUT_DIR% directory"
    MKDIR %OUTPUT_DIR%
)
PUSHD %OUTPUT_DIR%
SET OUTPUT_DIR=%CD%
POPD
echo Output path is %OUTPUT_DIR%

SET INPUT_DIR=.\in
IF NOT EXIST "%INPUT_DIR%" (
    echo "Making %INPUT_DIR% directory"
    MKDIR %INPUT_DIR%
)
PUSHD %INPUT_DIR%
SET INPUT_DIR=%CD%
POPD
echo Input path is %INPUT_DIR%

REM Working Copy, it's not be altered
SET ORIGINAL_SOURCE=..\js
PUSHD %ORIGINAL_SOURCE%
SET ORIGINAL_SOURCE=%CD%
POPD
echo Original source path is %ORIGINAL_SOURCE%

echo Continue?
pause

echo Erasing old documentation

IF EXIST "%OUTPUT_DIR%" (
    del /F/S/Q "%OUTPUT_DIR%" 1>nul
) ELSE (
    echo "Making %OUTPUT_DIR% directory"
    md "%OUTPUT_DIR%"
)
echo          Done!

echo Erasing old sources
IF EXIST "%INPUT_DIR%" (
    del /F/S/Q "%INPUT_DIR%" 1>nul
) ELSE (
    echo "Making %INPUT_DIR% directory"
    md "%INPUT_DIR%"
)
echo          Done!

echo Coping new Sources
xcopy /E /Y /C /I /Q /H /R  "%ORIGINAL_SOURCE%\*" "%INPUT_DIR%"

echo Cleaning .svn and .git folders
PUSHD .\
cd "%INPUT_DIR%"
for /d /r . %%d in (.svn) do @if exist "%%d" rd /s/q "%%d"
for /d /r . %%d in (.git) do @if exist "%%d" rd /s/q "%%d"
POPD

echo          Done!

echo JSDOC!
jsdoc -c %CONFIG% -t %TEMPLATE% -r %INPUT_DIR% -d %OUTPUT_DIR%
echo          Done!