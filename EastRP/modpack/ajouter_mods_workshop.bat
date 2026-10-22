@echo off
rem Ajoute / met a jour les mods du Workshop listes dans ajouter_mods_workshop.ps1 (copie + signature)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0ajouter_mods_workshop.ps1"
pause
