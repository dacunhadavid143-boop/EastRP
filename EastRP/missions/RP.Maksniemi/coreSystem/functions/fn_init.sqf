/* CORE_fnc_init (postInit) */
if (isServer) then {
    CORE_sessions = createHashMap;     // uid -> données du joueur
    CORE_dirty = false;

    // Déconnexion : on capture l'état physique (équipement, position) PUIS on sauvegarde
    addMissionEventHandler ["HandleDisconnect", {
        params ["_unit", "_id", "_uid", "_name"];
        if (_uid != "") then {
            [_unit] call CORE_fnc_capture;
            [_uid] call CORE_fnc_savePlayer;
            CORE_sessions deleteAt _uid;
            if (CORE_dirty) then { saveProfileNamespace; CORE_dirty = false; };
            diag_log format ["[CORE] %1 déconnecté, données sauvegardées", _name];
        };
        false
    }];

    // Mort : le joueur perd son équipement et sa position sauvegardés (l'argent est conservé)
    addMissionEventHandler ["EntityKilled", {
        params ["_victim"];
        if (isPlayer _victim) then {
            private _hm = CORE_sessions getOrDefault [getPlayerUID _victim, createHashMap];
            if (count _hm > 0) then {
                _hm set ["loadout", []];
                _hm set ["pos", []];
                [getPlayerUID _victim] call CORE_fnc_savePlayer;
            };
            _victim setVariable ["CORE_active", false];
        };
    }];

    // Effacer des éléments du décor de la carte (arbres, buissons, rochers...) sans les fichiers sources de la carte :
    // place dans l'éditeur un marqueur ZONE (ellipse ou rectangle) nommé hide_1, hide_2... et règle sa taille : tout le décor naturel dedans disparaît.
    // Nommé hideall_1, hideall_2... : efface AUSSI les bâtiments, murs et clôtures de la carte dans la zone.
    {
        private _all = (toLower _x find "hideall_") == 0;
        if (_all || {(toLower _x find "hide_") == 0}) then {
            private _r = ((getMarkerSize _x) select 0) max ((getMarkerSize _x) select 1) max 2;
            private _types = if (_all) then { [] } else { ["TREE", "SMALL TREE", "BUSH", "ROCK", "ROCKS", "STONE", "HIDE"] };
            private _objs = nearestTerrainObjects [getMarkerPos _x, _types, _r, false, true];
            { _x hideObjectGlobal true; } forEach _objs;
            diag_log format ["[CORE] Zone %1 : %2 élément(s) du décor masqué(s) (rayon %3 m)", _x, count _objs, _r];
        };
    } forEach allMapMarkers;

    // Sauvegarde rapide : argent ET inventaire (équipement, objets achetés, position) écrits sur le disque
    //  - au plus 2 secondes après un achat, un passage au distributeur ou une consommation (CORE_flushSoon = true) ;
    //  - et de toute façon toutes les 30 secondes tant qu'un joueur est connecté.
    // Ainsi rien n'est perdu si la fenêtre du serveur est fermée brutalement.
    CORE_flushSoon = false;
    [] spawn {
        private _next = time + 30;
        while { true } do {
            sleep 2;
            if (count CORE_sessions > 0 && {CORE_flushSoon || {time > _next}}) then {
                if (CORE_flushSoon) then { sleep 1; };   // laisse le temps à l'objet acheté d'arriver dans l'inventaire
                CORE_flushSoon = false;
                _next = time + 30;
                { [_x] call CORE_fnc_capture; } forEach allPlayers;
                { [_x] call CORE_fnc_savePlayer; } forEach (keys CORE_sessions);
                saveProfileNamespace; CORE_dirty = false;
            };
        };
    };

    // Sauvegarde automatique
    [] spawn {
        private _t = (getNumber (missionConfigFile >> "CORE_Settings" >> "autosaveSeconds")) max 60;
        while { true } do { sleep _t; call CORE_fnc_saveAll; };
    };
};

// Test de connexion à la base de données (dbTest = 1)
if (isServer && {getNumber (missionConfigFile >> "CORE_Settings" >> "dbTest") == 1}) then { [] spawn CORE_fnc_dbTest; };

if (!hasInterface) exitWith {};

CORE_firstSpawn = true;
CORE_dblLock = 0;
if (isNil "CORE_itemUse") then { CORE_itemUse = createHashMap; };
// SPN_menuOpened [unit, premierSpawn] : on retient si c'est la connexion ou un respawn
[missionNamespace, "SPN_menuOpened", { CORE_firstSpawn = _this select 1; }] call BIS_fnc_addScriptedEventHandler;
[missionNamespace, "SPN_spawned", { _this call CORE_fnc_onSpawned; }] call BIS_fnc_addScriptedEventHandler;

// Argent affiché dans l'écran d'inventaire
[] spawn CORE_fnc_invMoney;
// Double-clic sur les objets enregistrés par les modules (CORE_fnc_registerItemUse)
[] spawn CORE_fnc_invWatch;
