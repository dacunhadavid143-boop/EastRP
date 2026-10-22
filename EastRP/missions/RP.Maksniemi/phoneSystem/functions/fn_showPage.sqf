/* Affiche une page : efface la page courante puis exécute le code de la nouvelle. params: [code, arguments] */
disableSerialization;
params ["_code", ["_args", []]];
{ ctrlDelete _x; } forEach PHN_page;
PHN_page = [];
PHN_refs = createHashMap;
if (!isNull (uiNamespace getVariable ["PHN_homeBtnChrome", controlNull])) then { (uiNamespace getVariable "PHN_homeBtnChrome") ctrlEnable true; };
PHN_curPage = [_code, _args];
PHN_atHome = false;
PHN_onCallPage = false;
_args call _code;
