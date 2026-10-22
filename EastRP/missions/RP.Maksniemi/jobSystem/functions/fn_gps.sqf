/* CLIENT : fenêtre GPS (mini-carte en bas à droite, calque JOB_GpsHud). params: [afficher]
   L'itinéraire (trait bleu) et la position du joueur (flèche blanche) sont des marqueurs locaux (JOB_fnc_route),
   visibles aussi sur la grande carte. La mini-carte est recentrée sur le joueur en continu. */
disableSerialization;
params ["_show"];
private _d = uiNamespace getVariable ["JOB_gpsDisp", displayNull];
if (!_show) exitWith {
    if (!isNull _d) then { "JOB_gps" cutText ["", "PLAIN"]; };
    "JOB_me" setMarkerAlphaLocal 0;
};
if (isNull _d) then {
    "JOB_gps" cutRsc ["JOB_GpsHud", "PLAIN", 0, false];
    [] spawn {
        disableSerialization;
        uiSleep 0.1;
        private _z = getNumber (missionConfigFile >> "JOB_Settings" >> "gpsZoom");
        while { !isNull (uiNamespace getVariable ["JOB_gpsDisp", displayNull]) } do {
            private _m = (uiNamespace getVariable "JOB_gpsDisp") displayCtrl 75613;
            _m ctrlMapAnimAdd [0, _z, getPosATL player];
            ctrlMapAnimCommit _m;
            "JOB_me" setMarkerPosLocal (getPosATL player);
            "JOB_me" setMarkerDirLocal (getDir (vehicle player));
            "JOB_me" setMarkerAlphaLocal 1;
            uiSleep 0.02;
        };
    };
};
_d = uiNamespace getVariable ["JOB_gpsDisp", displayNull];
if (isNull _d || {JOB_tgt isEqualTo []}) exitWith {};
// distance restante (par la route si l'itinéraire est connu)
private _dist = player distance2D (JOB_tgt select 0);
private _r = JOB_rpts;
if (count _r > 1) then {
    private _k = JOB_rK;
    _dist = player distance2D (_r select _k);
    for "_i" from (_k + 1) to (count _r - 1) do { _dist = _dist + ((_r select (_i - 1)) distance2D (_r select _i)); };
};
(_d displayCtrl 75612) ctrlSetText format ["GPS  -  %1", if (_dist >= 1000) then { format ["%1 km", (round (_dist / 100)) / 10] } else { format ["%1 m", round _dist] }];
