@echo off
setlocal enabledelayedexpansion

for %%F in (*.iso *.cue) do (
    echo Se encontró: %%F
    set /p confirm="¿Deseas convertir este archivo? (s/n): "
    if /i "!confirm!"=="s" (
        set "output=%%~nF.chd"
        chdman createcd -i "%%F" -o "!output!"
        
        for %%A in (!output!) do set size=%%~zA
        echo Archivo convertido: !output! (Tamaño: !size! bytes)
        
        set /p confirm_delete="¿Es satisfactorio? ¿Eliminar el archivo original? (s/n): "
        if /i "!confirm_delete!"=="s" del "%%F"
    )
)

echo Proceso finalizado.
pause