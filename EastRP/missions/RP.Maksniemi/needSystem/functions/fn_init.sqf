/* NEED_fnc_init (postInit) */
if (isServer) then {
    diag_log "[NEED] module initialisé sur le serveur";
    // Valeurs par défaut quand le noyau a chargé le joueur
    [missionNamespace, "CORE_playerLoaded", { _this call NEED_fnc_loadDefaults; }] call BIS_fnc_addScriptedEventHandler;

    // Mort : faim et soif remises à la valeur de départ
    addMissionEventHandler ["EntityKilled", {
        params ["_v"];
        if (isPlayer _v) then {
            private _s = getNumber (missionConfigFile >> "NEED_Settings" >> "start");
            [_v, "hunger", _s] call CORE_fnc_setValue;
            [_v, "thirst", _s] call CORE_fnc_setValue;
        };
    }];

    // Boucle de diminution
    [] spawn {
        private _t = (getNumber (missionConfigFile >> "NEED_Settings" >> "tickSeconds")) max 5;
        while { true } do { sleep _t; call NEED_fnc_tick; };
    };
};

if (!hasInterface) exitWith {};

// Objets consommables : double-clic dans l'inventaire (service du module CORE)
{
    [configName _x, { params ["_c"]; [_c] call NEED_fnc_useItem; }, getText (_x >> "displayName")] call CORE_fnc_registerItemUse;
} forEach ("true" configClasses (missionConfigFile >> "NEED_CfgConsumables"));

[missionNamespace, "SPN_spawned", { _this call NEED_fnc_onSpawned; }] call BIS_fnc_addScriptedEventHandler;
[] spawn NEED_fnc_hudLoop;
[] spawn NEED_fnc_invPanel;
if (getNumber (missionConfigFile >> "CORE_Settings" >> "debug") == 1) then { systemChat "[NEED debug] module besoins initialisé"; };
