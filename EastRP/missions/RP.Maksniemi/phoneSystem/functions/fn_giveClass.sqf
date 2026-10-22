/* CLIENT : ajoute un objet / une arme / un vêtement / un sac / des chargeurs à l'inventaire. params: [classe, quantité] */
params ["_cls", ["_qty", 1]];
_qty = ((floor _qty) max 1) min 50;
private _cm = configFile >> "CfgMagazines" >> _cls;
private _cw = configFile >> "CfgWeapons" >> _cls;
private _cv = configFile >> "CfgVehicles" >> _cls;
if (isClass _cm) exitWith {
    for "_i" from 1 to _qty do { player addMagazine _cls; };
    systemChat format ["[Admin] Reçu : %1 x %2", _qty, _cls];
};
if (isClass _cw) exitWith {
    private _wt = getNumber (_cw >> "type");
    private _it = getNumber (_cw >> "ItemInfo" >> "type");
    if (_wt in [1, 2, 4]) then {
        player addWeapon _cls;
    } else {
        switch (_it) do {
            case 801: { player forceAddUniform _cls; };
            case 701: { player addVest _cls; };
            case 605: { player addHeadgear _cls; };
            case 616: { player addHeadgear _cls; };
            case 101: { player addGoggles _cls; };
            default   { for "_i" from 1 to _qty do { player addItem _cls; }; };
        };
    };
    systemChat format ["[Admin] Reçu : %1", _cls];
};
if (isClass _cv && {getNumber (_cv >> "isBackpack") == 1}) exitWith {
    player addBackpack _cls;
    systemChat format ["[Admin] Reçu : %1", _cls];
};
systemChat format ["[Admin] Classe inconnue : %1", _cls];
