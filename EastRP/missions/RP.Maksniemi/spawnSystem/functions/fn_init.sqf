/* SPN_fnc_init (postInit) : initialisation client uniquement */
if (!hasInterface) exitWith {};

// Toutes les variables du module sont préfixées SPN_
SPN_isOpen     = false;
SPN_selected   = -1;
SPN_points     = [];
SPN_cam        = objNull;
SPN_camEH      = -1;
SPN_camCenter  = [0,0,0];
SPN_camDist    = 12;
SPN_camHeight  = 5;
SPN_camAngle   = 0;
SPN_busy       = false;
SPN_camSpeed   = 5;
SPN_camLast    = diag_tickTime;

// Hook : d'autres modules peuvent ajouter des conditions { params ["_point"]; bool }
if (isNil "SPN_conditions") then { SPN_conditions = []; };
// Hooks exécutés AVANT le spawn : code { params ["_point"]; ... true/false } (peut attendre : exécuté en scheduled)
if (isNil "SPN_preSpawnHooks") then { SPN_preSpawnHooks = []; };

// Respawn : EH de mission => n'écrase rien, plusieurs scripts peuvent en avoir
addMissionEventHandler ["EntityRespawned", {
    params ["_new","_old"];
    if (_new isEqualTo player) then { [false] spawn SPN_fnc_open; };
}];

// Premier spawn
[] spawn {
    waitUntil { time > 0 && {!isNull player} && {!isNull (findDisplay 46)} };
    [true] spawn SPN_fnc_open;
};
