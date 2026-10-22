/* SPN_fnc_getPoints : lit la config et renvoie [[id, nom, desc, pos, dir, dist, haut], ...] */
private _result = [];
private _cfg = missionConfigFile >> "SPN_CfgSpawnPoints";
{
    private _marker = getText (_x >> "marker");
    private _useMarker = (_marker != "" && {markerType _marker != ""});
    private _pos = if (_useMarker) then { getMarkerPos _marker } else { getArray (_x >> "position") };
    private _dir = if (_useMarker) then { markerDir _marker } else { getNumber (_x >> "dir") };
    _result pushBack [
        configName _x,
        getText (_x >> "displayName"),
        getText (_x >> "description"),
        _pos, _dir,
        getNumber (_x >> "camDistance"),
        getNumber (_x >> "camHeight")
    ];
} forEach ("true" configClasses _cfg);
_result
