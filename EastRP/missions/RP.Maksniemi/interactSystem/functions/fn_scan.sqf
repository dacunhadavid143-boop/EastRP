/* Cherche les interactions disponibles autour du joueur. Renvoie [[ordre, libellé, action, cible, description de la cible], ...] trié. */
if (isNil "INT_actions" || {INT_actions isEqualTo []}) exitWith { INT_dbg = "aucune action enregistrée (le module n'est pas initialisé ?)"; [] };
private _co = cursorObject;
private _targets = createHashMap;          // type de cible -> [cible, description]

// Joueur proche (celui qu'on vise, sinon le plus proche à moins de 2,5 m)
private _pl = objNull;
if (!isNull _co && {isPlayer _co} && {_co != player} && {alive _co} && {player distance _co < 4}) then {
    _pl = _co;
} else {
    private _near = allPlayers select { _x != player && {alive _x} && {player distance _x < 2.5} };
    if (_near isNotEqualTo []) then { _pl = _near select 0; };
};
if (!isNull _pl) then { _targets set ["player", [_pl, name _pl]]; };

// PNJ (personnage non joueur) : visé, sinon le plus proche à moins de 2,5 m
private _npc = objNull;
if (!isNull _co && {_co isKindOf "CAManBase"} && {!isPlayer _co} && {alive _co} && {player distance _co < 4}) then {
    _npc = _co;
} else {
    private _nn = (nearestObjects [player, ["CAManBase"], 2.5]) select { _x != player && {!isPlayer _x} && {alive _x} };
    if (_nn isNotEqualTo []) then { _npc = _nn select 0; };
};
if (!isNull _npc) then { _targets set ["npc", [_npc, "Personnage"]]; };

// Véhicule / objet visé. On regarde ce que le regard touche à moins de 3,5 m (surface de l'objet : murs, bâtiments, caisses...),
// car la distance au CENTRE d'un grand objet ne convient pas ; les véhicules restent détectés jusqu'à 5 m.
private _eye = eyePos player;
private _hit = lineIntersectsSurfaces [_eye, _eye vectorAdd ((eyeDirection player) vectorMultiply 3.5), player, objNull, true, 1];
private _ro = objNull;
if (_hit isNotEqualTo []) then {
    _ro = (_hit select 0) select 2;
    if (isNull _ro) then { _ro = (_hit select 0) select 3; };
};
private _t = _ro;
if (!isNull _co && {_co isKindOf "AllVehicles"} && {!(_co isKindOf "CAManBase")} && {player distance _co < 5}) then { _t = _co; };
if (isNull _t && {!isNull _co} && {player distance _co < 3.5}) then { _t = _co; };
// Objet de travail (nommé job_... dans l'éditeur) à moins de 4 m : il est choisi même si le regard touche un autre objet
// (caisse voisine non nommée, table, palette...) ou si le modèle n'a pas de surface détectable (certains objets de mods).
if (isNull _t || {((toLower vehicleVarName _t) find "job_") != 0}) then {
    private _jo = (nearestObjects [player, [], 4]) select { ((toLower vehicleVarName _x) find "job_") == 0 && {!isPlayer _x} };
    if (_jo isNotEqualTo []) then { _t = _jo select 0; };
};
if (!isNull _t && {!isPlayer _t} && {!(_t isKindOf "CAManBase")}) then {
    private _name = getText (configFile >> "CfgVehicles" >> typeOf _t >> "displayName");
    if (_name == "") then { _name = "Objet"; };
    if (_t isKindOf "AllVehicles") then { _targets set ["vehicle", [_t, _name]]; } else { _targets set ["object", [_t, _name]]; };
};

// Points d'intérêt (marqueurs de l'éditeur)
if (time > INT_nextRefresh) then {
    INT_nextRefresh = time + 15;
    {
        private _pre = (INT_points get _x) select 1;
        INT_markers set [_x, allMapMarkers select { (_x find _pre) == 0 }];
    } forEach (keys INT_points);
};
{
    private _type = _x;
    (INT_points get _type) params ["_lbl", "_pre", "_rad"];
    private _best = "";
    private _bd = _rad;
    {
        private _d = player distance2D (getMarkerPos _x);
        if (_d < _bd) then { _bd = _d; _best = _x; };
    } forEach (INT_markers getOrDefault [_type, []]);
    if (_best != "") then { _targets set [format ["point:%1", _type], [_best, _lbl]]; };
} forEach (keys INT_points);

// Actions disponibles
private _out = [];
{
    _x params ["_id", "_label", "_kind", "_cond", "_use", "_order"];
    private _t = _targets getOrDefault [_kind, []];
    if (_t isNotEqualTo [] && {[_t select 0] call _cond}) then {
        private _lbl = if (_label isEqualType "") then { _label } else { [_t select 0] call _label };   // libellé fixe ou calculé selon la cible
        _out pushBack [_order, _lbl, _use, _t select 0, _t select 1];
    };
} forEach INT_actions;
INT_dbg = format ["cibles : %1 | regard : %2 | curseur : %3", keys _targets, if (isNull _ro) then { "rien" } else { typeOf _ro }, if (isNull _co) then { "rien" } else { format ["%1 à %2 m", typeOf _co, round (player distance _co)] }];
[_out, [], { _x select 0 }, "ASCEND"] call BIS_fnc_sortBy
