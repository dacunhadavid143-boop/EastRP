# Conventions du projet (à respecter pour CHAQUE module)

1. Un module = un dossier + un tag unique (fonctions TAG_fnc_xxx, variables TAG_xxx, classes UI TAG_xxx).
2. Chaque module a sa plage d'IDD/IDC (voir tableau). Ne jamais sortir de sa plage.
3. description.ext ne contient que des #include.
4. addMissionEventHandler uniquement (jamais onEachFrame). Pas de initPlayerLocal.sqf en dur.
5. Les modules communiquent par événements (BIS_fnc_callScriptedEventHandler) ou par hooks (tableaux de code).
6. Le serveur est l'autorité : argent, objets, véhicules ne sont JAMAIS modifiés par le client sans validation serveur.
7. remoteExec : whitelist CfgRemoteExec, chaque module déclare ses fonctions dans son remoteExec.hpp.
8. Un commit Git par fonctionnalité.

## Registre des tags et plages IDD/IDC
| Tag  | Module                        | Plage         |
|------|-------------------------------|---------------|
| SPN  | Spawn                         | 74100-74199   |
| DOC  | Documents d'identité          | 74200-74399   |
| CORE | Noyau (base de données, joueur)| 74400-74499  |
| ECO  | Économie, banque, boutiques   | 74500-74599   |
| JOB  | Emplois, usines               | 74600-74699   |
| POL  | Police, justice               | 74700-74799   |
| MED  | Médical                       | 74800-74899   |
| ILG  | Illégal                       | 74900-74999   |
| EDU  | Études, diplômes              | 75000-75099   |
| VEH  | Véhicules, garages            | 75100-75199   |
| HOU  | Logement                      | 75200-75299   |
| NEED | Faim, soif, santé (HUD)       | 75300-75399   |
