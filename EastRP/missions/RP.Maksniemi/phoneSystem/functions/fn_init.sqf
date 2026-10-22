/* PHN_fnc_init (postInit) : serveur + client */
disableSerialization;
// NB : aucune variable globale contenant un élément d'interface (PHN_display, PHN_clock, PHN_homeBtnChrome) n'est créée ici :
// elles sont créées plus tard, à l'ouverture du téléphone, dans des scripts qui désactivent la sérialisation.
if (isServer) then { [] call PHN_fnc_srvInit; };
if (!hasInterface) exitWith {};

PHN_open    = false;
if (isNil "PHN_apps") then { PHN_apps = []; };
PHN_page    = [];
PHN_chrome  = [];
PHN_refs    = createHashMap;
PHN_curPage = [];
PHN_atHome  = true;
PHN_onCallPage = false;
PHN_imgMode = false;
PHN_waTab = 1;
PHN_waTmp = ["", "", 0, "Disponible"];
PHN_waOpen = "";
// Thème du chat (sombre, vert)
PHN_wBg = [0.043, 0.078, 0.102, 1];
PHN_wPanel = [0.122, 0.173, 0.200, 1];
PHN_wGreen = [0.145, 0.827, 0.400, 1];
PHN_wOut = [0.000, 0.361, 0.294, 1];
PHN_wGray = [0.525, 0.600, 0.630, 1];
PHN_wBlue = [0.330, 0.740, 0.950, 1];
PHN_wStCols = [[0.10,0.55,0.50,1],[0.50,0.20,0.60,1],[0.85,0.40,0.15,1],[0.15,0.35,0.75,1],[0.75,0.15,0.30,1],[0.30,0.50,0.25,1]];
PHN_waStCol = 0;
PHN_waStText = "";
// Thème de la banque (noir)
PHN_rBg = [0, 0, 0, 1];
PHN_rCard = [0.098, 0.110, 0.122, 1];
PHN_rBlue = [0.024, 0.400, 0.922, 1];
PHN_rGreen = [0.000, 0.722, 0.420, 1];
PHN_capture = false;
PHN_call    = ["idle"];
PHN_dial    = "";
PHN_targetObj = objNull;
PHN_key  = profileNamespace getVariable ["PHN_key", getNumber (missionConfigFile >> "PHN_Settings" >> "defaultKey")];
PHN_wall = profileNamespace getVariable ["PHN_wall", 0];

call PHN_fnc_registerDefaultApps;

// Touche d'ouverture : écoute sur l'écran principal du jeu
[] spawn {
    waitUntil { !isNull findDisplay 46 };
    (findDisplay 46) displayAddEventHandler ["KeyDown", { _this call PHN_fnc_onKeyMain }];
};
