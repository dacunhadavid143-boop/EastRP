/* Application Admin (visible uniquement avec un rôle). Chaque action est RE-VÉRIFIÉE par le serveur. */
["Admin", true] call PHN_fnc_uiHeader;
[0.04, 0.072, 0.92, 0.035, format ["Rôle : %1", player getVariable ["PHN_roleName", "-"]], 0.022, [1,1,1,0.55]] call PHN_fnc_uiText;

if (isNull PHN_targetObj || {!(PHN_targetObj in allPlayers)}) then { PHN_targetObj = player; };
[0.04, 0.112, 0.92, 0.055, format ["Cible : %1  (changer)", name PHN_targetObj], [1,1,1,0.16], [1,1,1,1], {
    private _l = allPlayers;
    private _i = _l find PHN_targetObj;
    PHN_targetObj = _l select ((_i + 1) mod (count _l));
    [] call PHN_fnc_refresh;
}, [], 12, 0.026] call PHN_fnc_uiButton;

[0.04, 0.18, 0.44, 0.03, "Montant / quantité", 0.02, [1,1,1,0.55]] call PHN_fnc_uiText;
[0.52, 0.18, 0.44, 0.03, "Classe d'objet", 0.02, [1,1,1,0.55]] call PHN_fnc_uiText;
[0.04, 0.21, 0.44, 0.055, "", 0.03, "amount"] call PHN_fnc_uiEdit;
[0.52, 0.21, 0.44, 0.055, "", 0.026, "class"] call PHN_fnc_uiEdit;

private _perms = player getVariable ["PHN_perms", []];
private _god = missionNamespace getVariable ["PHN_god", false];
private _all = [
    ["+ Argent",           "money",   "money_add",  [0.20,0.62,0.35,1]],
    ["- Argent",           "money",   "money_take", [0.85,0.50,0.15,1]],
    ["Donner objet",       "item",    "item",       [0.30,0.55,0.95,1]],
    ["Arsenal",            "arsenal", "arsenal",    [0.55,0.35,0.85,1]],
    [format ["God mode : %1", if (_god) then { "ON" } else { "OFF" }], "god", "god", if (_god) then { [0.85,0.22,0.22,1] } else { [0.45,0.45,0.50,1] }],
    ["Soigner",            "heal",    "heal",       [0.20,0.62,0.35,1]],
    ["Besoins -30 (test)", "heal",    "needs",      [0.45,0.45,0.50,1]],
    ["Me TP vers cible",   "tp",      "tp_to",      [0.30,0.55,0.95,1]],
    ["Amener la cible",    "tp",      "tp_bring",   [0.30,0.55,0.95,1]],
    ["TP sur la carte",    "tp",      "tp_map",     [0.30,0.55,0.95,1]]
];
private _list = _all select { (_x select 1) in _perms };
{
    private _col = _forEachIndex mod 2;
    private _row = floor (_forEachIndex / 2);
    [0.04 + _col * 0.48, 0.30 + _row * 0.077, 0.44, 0.065, _x select 0, _x select 3, [1,1,1,1], { [_this select 0] call PHN_fnc_adminSend; }, _x select 2, 12, 0.024] call PHN_fnc_uiButton;
} forEach _list;
if (_list isEqualTo []) then { [0.04, 0.4, 0.92, 0.05, "Aucune permission.", 0.028, [1,1,1,0.5], "center"] call PHN_fnc_uiText; };
