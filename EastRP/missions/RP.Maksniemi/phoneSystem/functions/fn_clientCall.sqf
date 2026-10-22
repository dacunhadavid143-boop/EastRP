/* CLIENT : événement d'appel envoyé par le serveur. params: [événement, arguments] */
params ["_ev", "_args"];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};

private _showCall = {
    if (PHN_open) then { [PHN_fnc_pgCall, []] call PHN_fnc_showPage; } else { if (!dialog) then { [] call PHN_fnc_open; }; };
};

switch (_ev) do {
    case "incoming": {
        PHN_call = ["incoming", _args select 0];
        systemChat format ["[Téléphone] Appel entrant de %1", [_args select 0] call PHN_fnc_fmtPhone];
        call _showCall;
    };
    case "ringing": {
        PHN_call = ["ringing", _args select 0];
        call _showCall;
    };
    case "active": {
        PHN_call = ["active", _args select 0, time];
        setCurrentChannel (5 + (_args select 1));
        systemChat "[Téléphone] Appel connecté. Parlez avec votre touche de voix (canal Appel).";
        if (PHN_open) then { [PHN_fnc_pgCall, []] call PHN_fnc_showPage; };
    };
    case "ended": {
        PHN_call = ["idle"];
        PHN_dial = "";
        setCurrentChannel 5;
        systemChat format ["[Téléphone] %1", _args select 0];
        if (PHN_open && {PHN_onCallPage}) then { [PHN_fnc_pgDialer, []] call PHN_fnc_showPage; };
    };
};
