/* Événement SPN_spawned : double sécurité d'initialisation. params: [unit, pointId] */
params ["_unit"];
[_unit] remoteExec ["NEED_fnc_srvHello", 2];

if (getNumber (missionConfigFile >> "NEED_Settings" >> "debug") == 1) then {
    [_unit] spawn {
        params ["_u"];
        uiSleep 12;
        if (isNil { _u getVariable "NEED_hunger" }) then {
            systemChat "[NEED debug] Aucune donnée faim/soif reçue du serveur (voir le .rpt, lignes [NEED] et [CORE]).";
        } else {
            systemChat format ["[NEED debug] Données reçues : faim %1, soif %2", round (_u getVariable "NEED_hunger"), round (_u getVariable "NEED_thirst")];
        };
    };
};
