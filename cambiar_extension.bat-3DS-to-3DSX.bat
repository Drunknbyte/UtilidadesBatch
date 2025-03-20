@echo off
setlocal enabledelayedexpansion

set /a count=0

for %%F in (*.3ds) do (
    ren "%%F" "%%~nF.3dsx"
    set /a count+=1
)

echo.
echo Archivos renombrados: %count%
pause