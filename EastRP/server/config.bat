@echo off
rem === A ADAPTER ===
set ARMA_DIR=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server
set STEAMCMD_DIR=C:\steamcmd
set MISSION=RP.Maksniemi
set PORT=2302

rem Mods charges par le serveur : notre modpack (tous les mods regroupes + notre addon eastrp_core).
rem Il est construit par EastRP\modpack\construire_modpack.bat. Le CLIENT doit charger le MEME modpack dans le launcher.
set MODS=D:\EastRP_Modpack\@EastRP

rem Ancienne methode (mods Workshop un par un), gardee pour memoire :
rem set WS=C:\Program Files (x86)\Steam\steamapps\workshop\content\107410
rem set MODS=%WS%\450814997;%WS%\3640732171;%WS%\2721276071;%WS%\2721479458;%WS%\539126468;%WS%\3144699854;%WS%\3784742616;%WS%\3144435394
