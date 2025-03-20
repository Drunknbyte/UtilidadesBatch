@echo off
setlocal enabledelayedexpansion

rem Mostrar mensaje inicial
echo Generando listado de archivos en la carpeta actual...

rem Contar archivos en la carpeta y listarlos
set /a count=0
for %%F in (*) do (
    set /a count+=1
    echo Archivo encontrado: %%F
)

rem Definir el nombre del archivo con la cantidad de archivos
set "filename=listado_archivos_!count!.txt"

rem Crear el archivo de texto con los nombres de los archivos
(
    echo Listado de archivos en la carpeta:
    echo.
    for %%F in (*) do echo %%F
) > "!filename!"

rem Mostrar resultados finales en consola
echo.
echo Se encontraron !count! archivos en la carpeta.
echo El listado se ha guardado en el archivo: !filename!
pause
