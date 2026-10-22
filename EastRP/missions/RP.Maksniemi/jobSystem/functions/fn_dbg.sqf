/* Message de diagnostic (si JOB_Settings >> debug = 1). params: [texte] */
params [["_m", ""]];
if (getNumber (missionConfigFile >> "JOB_Settings" >> "debug") != 1) exitWith {};
private _t = format ["[JOB debug] %1", _m];
diag_log _t;
if (hasInterface) then { systemChat _t; };
