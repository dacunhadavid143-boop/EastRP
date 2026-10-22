@echo off
rem Construit le modpack D:\EastRP_Modpack\@EastRP : copie de tous les mods de D:\@EastRP + signature avec notre cle EastRP
rem Reglages : voir construire_modpack.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0construire_modpack.ps1"
pause
