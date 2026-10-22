/* CLIENT : repère de la tâche en cours : flèche 3D au-dessus du point, marqueur sur la carte, GPS (métiers avec gps = 1) */
private _cfg = missionConfigFile >> "JOB_Settings";
private _mk = createMarkerLocal ["JOB_mk", [0, 0, 0]];
_mk setMarkerTypeLocal "hd_objective";
_mk setMarkerColorLocal "ColorOrange";
_mk setMarkerAlphaLocal 0;
JOB_arrow = objNull;
JOB_route = [];
private _routeFor = [];
private _routeAt = 0;
while { true } do {
    private _s = player getVariable ["JOB_state", []];
    private _pt = "";
    if (count _s > 0 && {_s select 8} && {(_s select 13) != ""}) then {
        _pt = _s select 7;
        if (_pt == "") then {
            private _best = 1e9;
            {
                private _d = player distance2D ([_x] call JOB_fnc_pointPos);
                if (_d < _best) then { _best = _d; _pt = _x; };
            } forEach ([_s select 13] call JOB_fnc_pointList);
        };
    };
    private _top = if (_pt == "") then { [] } else { [_pt] call JOB_fnc_pointTop };
    if (_top isEqualTo []) then {
        JOB_tgt = [];
        JOB_route = [];
        _routeFor = [];
        ["clear"] call JOB_fnc_route;
        "JOB_mk" setMarkerAlphaLocal 0;
        if (!isNull JOB_arrow) then { deleteVehicle JOB_arrow; JOB_arrow = objNull; };
        [false] call JOB_fnc_gps;
    } else {
        JOB_tgt = [_top vectorAdd [0, 0, 1.6], _s select 6];
        "JOB_mk" setMarkerPosLocal _top;
        "JOB_mk" setMarkerTextLocal (_s select 6);
        "JOB_mk" setMarkerAlphaLocal 1;
        // Flèche 3D au-dessus du point
        if (isNull JOB_arrow) then {
            private _cls = getText (_cfg >> "arrowClass");
            if !(isClass (configFile >> "CfgVehicles" >> _cls)) then { _cls = "Sign_Arrow_Large_F"; };
            JOB_arrow = _cls createVehicleLocal [0, 0, 0];
            JOB_arrow enableSimulation false;
        };
        JOB_arrow setPosATL (ASLToATL (AGLToASL _top));
        // GPS : itinéraire par la route, recalculé quand la cible change ou toutes les 10 s
        private _gpsOn = (_s param [20, 0]) == 1 && {player distance2D _top > 25};
        if (_gpsOn) then {
            private _off = 1e6;
            { _off = _off min (player distance2D _x); } forEach JOB_rpts;
            if ((_routeFor isNotEqualTo _top || {_off > 40}) && {time > _routeAt}) then {
                _routeFor = _top;
                _routeAt = time + 4;
                private _ag = calculatePath ["car", "safe", getPosATL player, _top];
                _ag addEventHandler ["PathCalculated", { params ["_a", "_path"]; if (count _path > 1) then { JOB_route = _path; ["set", _path] call JOB_fnc_route; }; [_a] spawn { sleep 15; deleteVehicle (_this select 0); }; }];
            };
            ["update"] call JOB_fnc_route;
        } else { if (count JOB_rMk > 0) then { ["clear"] call JOB_fnc_route; }; JOB_route = []; };
        [_gpsOn] call JOB_fnc_gps;
        // Étape « au volant » : se déclenche toute seule en arrivant au point avec le véhicule de service
        if ((_s param [18, ""]) == "veh" && {!JOB_busy} && {vehicle player != player} && {driver (vehicle player) == player}
            && {([player, _pt] call JOB_fnc_pointDist) < getNumber (_cfg >> "vehRadius")}) then {
            [_pt] spawn JOB_fnc_doStep;
        };
    };
    sleep 1;
};
