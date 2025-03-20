@echo off
setlocal enabledelayedexpansion

set "found=0"

for %%F in (*.iso *.cue) do (
    set "found=1"
    echo Se encontró: %%F
    set /p confirm="¿Deseas convertir este archivo? (s/n): "
    if /i "!confirm!"=="s" (
        set "output=%%~nF.chd"
        chdman createcd -i "%%F" -o "!output!"
        
        for %%A in (!output!) do set size=%%~zA
        echo Archivo convertido: !output! (Tamaño: !size! bytes)
        
        set /p confirm_delete="¿Es satisfactorio? ¿Eliminar el archivo original? (s/n): "
        if /i "!confirm_delete!"=="s" (
            del "%%F"
            if "%%~xF"==".cue" (
                for %%B in ("%%~nF"*.bin) do del "%%B"
            )
        )
    )
)

if %found%==0 echo No se encontraron archivos .iso o .cue en la carpeta actual.

echo Proceso finalizado.
pause
