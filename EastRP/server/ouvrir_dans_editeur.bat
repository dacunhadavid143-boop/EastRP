@echo off
rem Cree un lien entre le dossier de missions de l'editeur et la mission du projet.
rem Apres ca, tout ce que tu enregistres dans l'editeur (Eden) modifie directement le projet. A lancer UNE seule fois.
call "%~dp0config.bat"
set PROFIL=%USERPROFILE%\Documents\Arma 3 - Other Profiles\TON_PROFIL_ARMA\missions
set LIEN=%PROFIL%\%MISSION%
if exist "%LIEN%" (
    echo Le lien existe deja : %LIEN%
) else (
    mklink /J "%LIEN%" "%~dp0..\missions\%MISSION%"
)
echo.
echo Dans Arma 3 : Editeur ^> Ouvrir ^> choisis "RP" sur la carte Maksniemi.
pause
