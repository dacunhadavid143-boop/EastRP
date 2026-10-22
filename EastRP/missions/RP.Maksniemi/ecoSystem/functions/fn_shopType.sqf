/* Type de catalogue d'une boutique ("" si ce n'est pas une boutique ou si le type est inconnu). params: [objet]
   Ordre :
   1. variable de l'objet "eastrp_shop" (champ Init de l'éditeur) ;
   2. propriété eastrp_shop de la classe (mod @EastRP) ;
   3. CAISSE / BORNE (classe listée dans ECO_Settings >> counterClasses) : prend le type du bâtiment-boutique le plus proche
      (ECO_ShopClasses, dans un rayon de counterRadius m), sinon "general" ;
   4. le bâtiment lui-même (ECO_ShopClasses), seulement si buildingShops = 1. */
params ["_o"];
if (isNull _o) exitWith { "" };

// le nom de classe commence-t-il par un des noms de la liste ? (correspondance sur le début du nom)
private _startsWith = {
    params ["_cls", "_list"];
    private _found = false;
    { if (_cls find (toLower _x) == 0) exitWith { _found = true; }; } forEach _list;
    _found
};
// type de catalogue d'un bâtiment d'après ECO_ShopClasses ("" si aucun)
private _buildingType = {
    params ["_b"];
    private _cls = toLower typeOf _b;
    private _r = "";
    {
        if (_cls find (toLower configName _x) == 0) exitWith { _r = getText _x; };
    } forEach configProperties [missionConfigFile >> "ECO_ShopClasses", "isText _x"];
    _r
};

private _t = _o getVariable ["eastrp_shop", ""];
if (_t == "") then { _t = getText (configFile >> "CfgVehicles" >> typeOf _o >> "eastrp_shop"); };

if (_t == "") then {
    private _set = missionConfigFile >> "ECO_Settings";
    if ([toLower typeOf _o, getArray (_set >> "counterClasses")] call _startsWith) then {
        // caisse / borne : résultat gardé en mémoire sur l'objet (calculé une seule fois)
        _t = _o getVariable ["eastrp_shopAuto", ""];
        if (_t == "") then {
            private _best = "";
            private _bestD = 1e6;
            {
                private _bt = [_x] call _buildingType;
                if (_bt != "" && {_x != _o}) then {
                    private _d = _o distance _x;
                    if (_d < _bestD) then { _bestD = _d; _best = _bt; };
                };
            } forEach (nearestObjects [_o, [], getNumber (_set >> "counterRadius"), true]);
            _t = if (_best == "") then { "general" } else { _best };
            _o setVariable ["eastrp_shopAuto", _t];
        };
    } else {
        if (getNumber (_set >> "buildingShops") == 1) then { _t = [_o] call _buildingType; };
    };
};
if (_t == "" || {!isClass (missionConfigFile >> "ECO_Shops" >> _t)}) exitWith { "" };
_t
