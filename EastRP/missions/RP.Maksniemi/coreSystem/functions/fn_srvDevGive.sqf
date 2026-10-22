/* SERVEUR (devMode uniquement) : outil de test. params: [unit, "cash"|"bank", montant(+/-)] */
if (!isServer) exitWith {};
if (getNumber (missionConfigFile >> "CORE_Settings" >> "devMode") != 1) exitWith {};
params [["_unit", objNull, [objNull]], "_what", "_a"];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith {};
if !(_what in ["cash", "bank"]) exitWith {};
if !([_unit, _what, _a] call CORE_fnc_changeMoney) then {
    ["[CORE] Opération refusée (solde insuffisant)"] remoteExec ["CORE_fnc_clientMsg", _unit];
};
