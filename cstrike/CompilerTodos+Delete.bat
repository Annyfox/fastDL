@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"

set "SevenZipPath=C:\Program Files\7-Zip\7z.exe"

if not exist "!SevenZipPath!" (
    echo ERRO: 7-Zip nao encontrado em "!SevenZipPath!"
    pause
    exit /b
)

for /R %%f in (*) do (
    if /I not "%%~f"=="%~f0" (
        if /I not "%%~xf"==".bz2" (
            set "filepath=%%~dpf"
            set "filename=%%~nxf"

            pushd "!filepath!"
            echo Compactando: !filename!

            rem Cria/atualiza o .bz2
            "!SevenZipPath!" a -tbzip2 "!filename!.bz2" "!filename!" >nul
            if exist "!filename!.bz2" (
                del /f /q "!filename!"
            )

            popd
        )
    )
)

pause