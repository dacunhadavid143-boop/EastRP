/* CLIENT : message reçu / mise à jour du chat (envoyé par le serveur). params: [numéro émetteur, texte, notifier(bool)] */
params ["_from", "_text", ["_notify", true]];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
if (_notify && {_from != ""}) then {
    private _n = [_from] call PHN_fnc_waName;
    systemChat format ["[%1] %2 : %3", ["messages"] call PHN_fnc_appName, _n, _text];
    "PHN_notif" cutText [format ["Nouveau message de %1", _n], "PLAIN DOWN", 0.3];
    [] spawn { uiSleep 3.5; "PHN_notif" cutText ["", "PLAIN"]; };
};
if (PHN_open) then { [0.3] call PHN_fnc_refresh; };
