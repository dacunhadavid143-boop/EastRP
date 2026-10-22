/* CLIENT : trace l'itinéraire GPS avec des marqueurs locaux (traits épais en couleur), visibles sur le GPS et la grande carte.
   params: ["set", points] = nouvel itinéraire ; ["update"] = efface la partie déjà parcourue ; ["clear"] */
params ["_op", ["_pts", []]];
private _seg = {
    params ["_name", "_a", "_b"];
    private _len = _a distance2D _b;
    if (getMarkerType _name == "" && {markerShape _name == ""}) then { createMarkerLocal [_name, _a]; };
    _name setMarkerShapeLocal "RECTANGLE";
    _name setMarkerBrushLocal "SolidFull";
    _name setMarkerColorLocal "ColorBlue";
    _name setMarkerPosLocal [((_a select 0) + (_b select 0)) / 2, ((_a select 1) + (_b select 1)) / 2];
    _name setMarkerSizeLocal [getNumber (missionConfigFile >> "JOB_Settings" >> "gpsWidth"), (_len / 2) + 1];
    _name setMarkerDirLocal (_a getDir _b);
    _name setMarkerAlphaLocal 1;
};
switch (_op) do {
    case "clear": {
        { deleteMarkerLocal _x; } forEach JOB_rMk;
        deleteMarkerLocal "JOB_r_head";
        JOB_rMk = []; JOB_rpts = []; JOB_rK = 0;
    };
    case "set": {
        ["clear"] call JOB_fnc_route;
        // simplification : un point tous les 15 m environ
        private _s = [_pts select 0];
        { if ((_x distance2D (_s select (count _s - 1))) > 15) then { _s pushBack _x; }; } forEach _pts;
        if ((_s select (count _s - 1)) isNotEqualTo (_pts select (count _pts - 1))) then { _s pushBack (_pts select (count _pts - 1)); };
        JOB_rpts = _s apply { [_x select 0, _x select 1, 0] };
        JOB_rK = 0;
        for "_i" from 1 to (count JOB_rpts - 1) do {
            private _n = format ["JOB_r_%1", _i];
            [_n, JOB_rpts select (_i - 1), JOB_rpts select _i] call _seg;
            JOB_rMk pushBack _n;
        };
        ["update"] call JOB_fnc_route;
    };
    case "update": {
        if (count JOB_rpts < 2) exitWith {};
        // point de l'itinéraire le plus proche, en ne revenant jamais en arrière
        private _k = JOB_rK;
        private _bd = 1e9;
        for "_i" from JOB_rK to (count JOB_rpts - 1) do {
            private _d = player distance2D (JOB_rpts select _i);
            if (_d < _bd) then { _bd = _d; _k = _i; };
        };
        for "_i" from (JOB_rK + 1) to _k do { deleteMarkerLocal format ["JOB_r_%1", _i]; };
        JOB_rK = _k;
        ["JOB_r_head", getPosATL player, JOB_rpts select _k] call _seg;
    };
};
