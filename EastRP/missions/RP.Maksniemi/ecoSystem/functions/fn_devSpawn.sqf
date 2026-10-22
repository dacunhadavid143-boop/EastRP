/* SERVEUR, devMode uniquement : crée un distributeur et une boutique de test à côté du point d'apparition (marqueur spn_port),
   pour tester l'économie sans rien placer dans l'éditeur. Désactivé quand devMode = 0 (CORE_Settings). */
if (!isServer) exitWith {};
if (getNumber (missionConfigFile >> "CORE_Settings" >> "devMode") != 1) exitWith {};
[] spawn {
    uiSleep 5;
    private _m = getMarkerPos "spn_port";
    if (_m isEqualTo [0, 0, 0]) exitWith { diag_log "[ECO] devSpawn : marqueur spn_port introuvable, rien créé."; };
    private _mk = {
        params ["_cls", "_off", "_dir"];
        private _p = _m vectorAdd _off;
        private _o = createVehicle [_cls, _p, [], 0, "CAN_COLLIDE"];
        _o setDir _dir;
        _o setPosATL [_p select 0, _p select 1, 0];
        _o
    };
    private _atm = ["Land_Atm_01_F", [6, 0, 0], 90] call _mk;
    private _shop = ["Land_Kiosk_blueking_F", [12, 0, 0], 90] call _mk;
    _shop setVariable ["eastrp_shop", "epicerie", true];
    diag_log format ["[ECO] devSpawn : distributeur de test en %1, boutique de test en %2", getPosATL _atm, getPosATL _shop];
};
