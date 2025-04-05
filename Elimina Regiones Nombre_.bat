@echo off
setlocal enabledelayedexpansion

title Limpiador Completo de Nombres de Archivos
color 0A
mode con: cols=100 lines=40

echo [INICIO] Procesando nombres de archivos en la carpeta actual...
echo ======================================================================
echo.

:: Lista de patrones de idiomas/regiones a eliminar
set "patron1= (USA)"
set "patron2= (En,Fr,Es,Pt)"
set "patron3= (En,Fr,Es)"
set "patron4= (En,Fr,De,Es,It)"
set "patron5= (En,Fr,De,Es,It,Nl)"
set "patron6= (En,Fr,De)"
set "patron7= (Europe)"
set "patron8= (En,Fr)"
set "patron9= (En,Ja,Fr,De,Es,It,Zh,Ko)"
set "patron10= (En,Ja,Fr,De,Es,It,Ko)"
set "patron11= (En,Ja,Fr,De,Es,It)"
set "patron12=update "
set "patron13=[USA]"

:: Contador de archivos modificados
set /a modificados=0

echo Buscando archivos con patrones a eliminar...
echo.

for /f "delims=" %%F in ('dir /b /a-d *') do (
    set "nombre_original=%%F"
    set "nombre_nuevo=%%F"
    set "extension=%%~xF"
    
    :: --- ELIMINAR PATRÓN NUMÉRICO INICIAL (#### - ) ---
    set "primeros4=!nombre_nuevo:~0,4!"
    echo !primeros4!| findstr /r "^[0-9][0-9][0-9][0-9]$" >nul
    if !errorlevel! equ 0 (
        if "!nombre_nuevo:~4,3!"==" - " (
            set "nombre_nuevo=!nombre_nuevo:~7!"
        )
    )
    
    :: --- ELIMINAR PATRONES DE IDIOMAS/REGIONES ---
    set "nombre_nuevo=!nombre_nuevo:%patron1%=!"
    set "nombre_nuevo=!nombre_nuevo:%patron2%=!"
    set "nombre_nuevo=!nombre_nuevo:%patron3%=!"
    set "nombre_nuevo=!nombre_nuevo:%patron4%=!"
    set "nombre_nuevo=!nombre_nuevo:%patron5%=!"
    set "nombre_nuevo=!nombre_nuevo:%patron6%=!"
    set "nombre_nuevo=!nombre_nuevo:%patron7%=!"
    set "nombre_nuevo=!nombre_nuevo:%patron8%=!"
	set "nombre_nuevo=!nombre_nuevo:%patron9%=!"
	set "nombre_nuevo=!nombre_nuevo:%patron10%=!"
	set "nombre_nuevo=!nombre_nuevo:%patron11%=!"
	set "nombre_nuevo=!nombre_nuevo:%patron12%=!"
	set "nombre_nuevo=!nombre_nuevo:%patron13%=!"
    
    :: --- LIMPIEZA FINAL DE ESPACIOS ---
    :: Eliminar espacio antes de la extensión
    if "!nombre_nuevo:~-1!"==" " (
        set "nombre_nuevo=!nombre_nuevo:~0,-1!!extension!"
    )
    
    :: Eliminar espacios dobles
    :trim_spaces
    if "!nombre_nuevo:  =!" neq "!nombre_nuevo!" (
        set "nombre_nuevo=!nombre_nuevo:  = !"
        goto trim_spaces
    )
    
    :: --- RENOMBRAR ARCHIVO SI HUBO CAMBIOS ---
    if not "!nombre_nuevo!"=="!nombre_original!" (
        echo [ANTES] !nombre_original!
        echo [DESPUES] !nombre_nuevo!
        echo --------------------------
        ren "!nombre_original!" "!nombre_nuevo!" 2>nul
        if errorlevel 1 (
            echo [ERROR] No se pudo renombrar
        ) else (
            set /a modificados+=1
        )
    )
)

echo.
echo ======================================================================
echo Proceso completado.
echo Archivos modificados: !modificados!
echo ======================================================================
echo.
pause