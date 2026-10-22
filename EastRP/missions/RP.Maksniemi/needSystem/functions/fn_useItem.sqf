/* CLIENT : double-clic sur un consommable. params: [classe] */
params ["_cls"];
if (getNumber (missionConfigFile >> "NEED_Settings" >> "debug") == 1) then { systemChat format ["[NEED debug] utilisation de %1 : demande envoyée au serveur", _cls]; };
[player, _cls] remoteExec ["NEED_fnc_srvConsume", 2];
