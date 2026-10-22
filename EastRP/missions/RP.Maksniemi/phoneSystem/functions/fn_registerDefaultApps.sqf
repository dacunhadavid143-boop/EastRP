/* Applications de base du téléphone */
private _cfg = missionConfigFile >> "PHN_Settings";
private _chat = getText (_cfg >> "chatAppName");
private _bank = getText (_cfg >> "bankAppName");
if (_chat == "") then { _chat = "Chat"; };
if (_bank == "") then { _bank = "Banque"; };
["phone",    "Téléphone", [0.20,0.78,0.35,1], "",  PHN_fnc_pgDialer,   "",      true]  call PHN_fnc_registerApp;
["messages", _chat,       [0.15,0.80,0.38,1], "",  PHN_fnc_pgWa,       "",      true]  call PHN_fnc_registerApp;
["bank",     _bank,       [0.07,0.07,0.09,1], "",  PHN_fnc_pgBank,     "",      true]  call PHN_fnc_registerApp;
["settings", "Réglages",  [0.55,0.56,0.60,1], "",  PHN_fnc_pgSettings, "",      true]  call PHN_fnc_registerApp;
["admin",    "Admin",     [0.85,0.22,0.22,1], "",  PHN_fnc_pgAdmin,    "admin", false] call PHN_fnc_registerApp;
