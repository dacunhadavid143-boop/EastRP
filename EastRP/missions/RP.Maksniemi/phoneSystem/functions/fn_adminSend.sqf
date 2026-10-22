/* Envoie une action admin au serveur (qui vérifie le rôle). params: [action] */
params ["_act"];
private _amt = floor (parseNumber (ctrlText (PHN_refs getOrDefault ["amount", controlNull])));
private _cls = ctrlText (PHN_refs getOrDefault ["class", controlNull]);
private _tg = PHN_targetObj;
if (isNull _tg) then { _tg = player; };

private _send = { params ["_a", "_args"]; [player, _a, _args] remoteExec ["PHN_fnc_srvAdmin", 2]; };

switch (_act) do {
    case "money_add":  { if (_amt <= 0) exitWith { systemChat "[Admin] Saisissez un montant."; }; ["money", [_tg, _amt]] call _send; };
    case "money_take": { if (_amt <= 0) exitWith { systemChat "[Admin] Saisissez un montant."; }; ["money", [_tg, -_amt]] call _send; };
    case "item":       { if (_cls == "") exitWith { systemChat "[Admin] Saisissez une classe d'objet."; }; ["item", [_tg, _cls, _amt max 1]] call _send; };
    case "arsenal":    { closeDialog 0; ["arsenal", []] call _send; };
    case "god": {
        PHN_god = !(missionNamespace getVariable ["PHN_god", false]);
        ["god", [PHN_god]] call _send;
        [] call PHN_fnc_refresh;
    };
    case "heal":      { ["heal", [_tg]] call _send; };
    case "needs":     { ["needs", [_tg, -30]] call _send; };
    case "tp_to":     { ["tp_to", [_tg]] call _send; };
    case "tp_bring":  { ["tp_bring", [_tg]] call _send; };
    case "tp_map": {
        closeDialog 0;
        openMap true;
        systemChat "[Admin] Cliquez sur la carte pour vous téléporter.";
        addMissionEventHandler ["MapSingleClick", {
            params ["_units", "_pos"];
            [player, "tp_pos", [_pos]] remoteExec ["PHN_fnc_srvAdmin", 2];
            removeMissionEventHandler ["MapSingleClick", _thisEventHandler];
            openMap false;
        }];
    };
};
