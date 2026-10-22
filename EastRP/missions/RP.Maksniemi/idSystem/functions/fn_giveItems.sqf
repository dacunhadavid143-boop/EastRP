/* Donne la carte d'identité (et le permis s'il existe). params: [unit] */
params ["_unit"];
if (DOC_identity isEqualTo []) exitWith {};
private _cfg = missionConfigFile >> "DOC_Settings";
private _list = [getText (_cfg >> "itemIdCard")];
if ((DOC_identity select 11) != "") then { _list pushBack getText (_cfg >> "itemLicense"); };
{
    if !(_x in items _unit) then {
        if (_unit canAddItemToUniform _x) then { _unit addItemToUniform _x; } else { _unit addItem _x; };
    };
} forEach _list;
