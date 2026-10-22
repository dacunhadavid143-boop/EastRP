/* Message de diagnostic (si ECO_Settings >> debug = 1) : chat + .rpt. params: [texte] */
params [["_m", ""]];
if (getNumber (missionConfigFile >> "ECO_Settings" >> "debug") != 1) exitWith {};
private _t = format ["[ECO debug] %1", _m];
diag_log _t;
if (hasInterface) then { systemChat _t; };
