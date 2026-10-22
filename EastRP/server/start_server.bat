@echo off
call "%~dp0config.bat"
if not exist "%~dp0server.cfg" copy "%~dp0server.cfg.example" "%~dp0server.cfg"
if not exist "%~dp0profiles" mkdir "%~dp0profiles"

rem Verifie que chaque mod existe avant de lancer
set MANQUE=0
for %%m in ("%MODS:;=" "%") do (
    if not exist "%%~m\addons" if not exist "%%~m\Addons" (
        echo [ERREUR] Mod introuvable : %%~m
        set MANQUE=1
    )
)
if "%MANQUE%"=="1" (
    echo Un ou plusieurs mods sont absents : abonne-toi au mod sur le Workshop puis relance.
    pause
    exit /b 1
)

call "%~dp0sync_mission.bat"
cd /d "%ARMA_DIR%"
start "Arma 3 Server" arma3server_x64.exe -port=%PORT% "-config=%~dp0server.cfg" "-profiles=%~dp0profiles" -name=server -world=empty -autoInit "-mod=%MODS%"
echo Serveur lance. Connexion en jeu : Multijoueur ^> Connexion directe ^> 127.0.0.1:%PORT%
