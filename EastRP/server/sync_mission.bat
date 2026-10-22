@echo off
rem Copie la mission du projet vers le dossier MPMissions du serveur
call "%~dp0config.bat"
if not exist "%ARMA_DIR%\MPMissions" mkdir "%ARMA_DIR%\MPMissions"
robocopy "%~dp0..\missions\%MISSION%" "%ARMA_DIR%\MPMissions\%MISSION%" /MIR /NFL /NDL /NJH /NJS
echo Mission synchronisee : %MISSION%
