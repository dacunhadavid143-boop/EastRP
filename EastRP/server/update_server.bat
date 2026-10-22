@echo off
call "%~dp0config.bat"
"%STEAMCMD_DIR%\steamcmd.exe" +force_install_dir "%ARMA_DIR%" +login anonymous +app_update 233780 validate +quit
pause
