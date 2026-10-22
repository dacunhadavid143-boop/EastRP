/* SERVEUR : rôle et permissions d'un joueur, d'après ses SteamID64 dans PHN_Roles. params: [unit] -> [nomDuRôle, permissions] */
private _unit = _this select 0;
private _uid = getPlayerUID _unit;
private _perms = [];
private _name = "";
{
    private _role = _x;
    if (_uid in (getArray (_role >> "uids"))) then {
        { if !(_x in _perms) then { _perms pushBack _x; }; } forEach (getArray (_role >> "perms"));
        if (_name == "") then { _name = getText (_role >> "displayName"); };
    };
} forEach ("true" configClasses (missionConfigFile >> "PHN_Roles"));

// Mode test : tout le monde est admin (à désactiver en production)
if (getNumber (missionConfigFile >> "CORE_Settings" >> "devMode") == 1 && {getNumber (missionConfigFile >> "PHN_Settings" >> "devAllAdmin") == 1}) then {
    _perms = getArray (missionConfigFile >> "PHN_Roles" >> "admin" >> "perms");
    _name = "Admin (mode test)";
};
[_name, _perms]
