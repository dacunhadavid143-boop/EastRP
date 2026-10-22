/* CLIENT : exécute une action admin validée par le serveur. params: [action, arguments] */
params ["_act", "_args"];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
switch (_act) do {
    case "item":    { [_args select 0, _args select 1] call PHN_fnc_giveClass; };
    case "arsenal": { [] spawn { uiSleep 0.3; ["Open", true] call BIS_fnc_arsenal; }; };
    case "god": {
        player allowDamage (!(_args select 0));
        systemChat format ["[Admin] God mode : %1", if (_args select 0) then { "ACTIVÉ" } else { "désactivé" }];
    };
    case "heal": { player setDamage 0; systemChat "[Admin] Soigné."; };
    case "tp":   { player setPosATL (_args select 0); };
};
