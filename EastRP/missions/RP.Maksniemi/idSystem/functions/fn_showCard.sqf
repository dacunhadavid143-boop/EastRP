/* Affiche une carte en haut à gauche. À appeler avec spawn.
   params: ["id"|"licence", données (optionnel : documents d'un autre joueur), porteur (optionnel : joueur dont on voit le visage)] */
disableSerialization;
params [["_type", "id"], ["_data", []], ["_holder", objNull]];
private _id = if (_data isEqualTo []) then { DOC_identity } else { _data };
private _unit = if (isNull _holder) then { player } else { _holder };
if (_id isEqualTo []) exitWith { systemChat "[DOC] Aucun document."; };
if (_type == "licence" && {(_id select 11) == ""}) exitWith { systemChat "[DOC] Vous n'avez pas de permis."; };

uiNamespace setVariable ["DOC_cardDisplay", displayNull];
"DOC_cardLayer" cutRsc ["DOC_CardHUD", "PLAIN", 0.4, false];
private _t = diag_tickTime + 2;
waitUntil { !isNull (uiNamespace getVariable ["DOC_cardDisplay", displayNull]) || diag_tickTime > _t };
private _d = uiNamespace getVariable ["DOC_cardDisplay", displayNull];
if (isNull _d) exitWith {};

private _set = { params ["_idc", "_txt"]; (_d displayCtrl _idc) ctrlSetText _txt; };
private _cfg = missionConfigFile >> "DOC_Settings";
private _country = getText (_cfg >> "country");
private _first = _id select 0;
private _last  = _id select 1;
private _sexTxt = if ((_id select 2) == "M") then {"M / М"} else {"F / Ж"};
private _dob = [_id select 3] call DOC_fnc_fmtDate;

// Ligne MRZ (style document de voyage de l'est)
private _pad = {
    params ["_s", "_n"];
    while { count _s < _n } do { _s = _s + "<"; };
    _s select [0, _n]
};
private _lastU = toUpper (_last splitString " " joinString "<");
private _firstU = toUpper (_first);

if (_type == "id") then {
    (_d displayCtrl 74301) ctrlSetBackgroundColor [0.12,0.22,0.42,0.95];
    [74303, "CARTE D'IDENTITE / УДОСТОВЕРЕНИЕ ЛИЧНОСТИ"] call _set;
    [74305, "N° " + (_id select 8)] call _set;
    private _rows = [
        ["NOM / ФАМИЛИЯ", _last],
        ["PRENOM / ИМЯ", _first],
        ["SEXE / ПОЛ", _sexTxt],
        ["NE(E) LE / ДАТА РОЖД.", _dob],
        ["LIEU DE NAISS. / МЕСТО РОЖД.", _id select 4],
        ["TAILLE-YEUX / РОСТ-ГЛАЗА", format ["%1 cm / %2", _id select 5, _id select 6]],
        ["NATIONALITE / ГРАЖДАНСТВО", _id select 7]
    ];
    { [74310 + _forEachIndex, _x select 0] call _set; [74320 + _forEachIndex, _x select 1] call _set; } forEach _rows;
    [74332, "Délivrée " + ([_id select 9] call DOC_fnc_fmtDate)] call _set;
    [74333, "Expire   " + ([_id select 10] call DOC_fnc_fmtDate)] call _set;
    [74330, ["ID<<NRD" + _lastU + "<<" + _firstU, 36] call _pad] call _set;
    [74331, [((_id select 8) splitString " " joinString "") + "<<" + ([_id select 3] call { params ["_a"]; format ["%1%2%3", _a select 2, _a select 1, _a select 0] }) + (_id select 2), 36] call _pad] call _set;
} else {
    (_d displayCtrl 74301) ctrlSetBackgroundColor [0.16,0.34,0.22,0.95];
    [74303, "PERMIS DE CONDUIRE / ВОДИТЕЛЬСКОЕ УДОСТОВЕРЕНИЕ"] call _set;
    [74305, "N° " + (_id select 12)] call _set;
    private _rows = [
        ["NOM / ФАМИЛИЯ", _last],
        ["PRENOM / ИМЯ", _first],
        ["NE(E) LE / ДАТА РОЖД.", _dob],
        ["LIEU DE NAISS. / МЕСТО РОЖД.", _id select 4],
        ["CATEGORIES / КАТЕГОРИИ", _id select 11],
        ["DELIVRE / ВЫДАНО", [_id select 13] call DOC_fnc_fmtDate],
        ["EXPIRE / ДЕЙСТВИТЕЛЕН ДО", [_id select 14] call DOC_fnc_fmtDate]
    ];
    { [74310 + _forEachIndex, _x select 0] call _set; [74320 + _forEachIndex, _x select 1] call _set; } forEach _rows;
    [74332, ""] call _set;
    [74333, ""] call _set;
    [74330, ["DL<<NRD" + _lastU + "<<" + _firstU, 36] call _pad] call _set;
    [74331, [((_id select 12) splitString " " joinString "") + "<<" + (_id select 11), 36] call _pad] call _set;
};
[74304, _country] call _set;

// ---- Photo : une caméra filme le visage du joueur, rendu dans le cadre photo ----
if (!isNull DOC_photoCam) then { camDestroy DOC_photoCam; };
private _cam = "camera" camCreate (getPosATL _unit);
DOC_photoCam = _cam;
_cam cameraEffect ["Internal", "Back", "docphoto"];
_cam camSetFov 0.5;
(_d displayCtrl 74306) ctrlSetText "#(argb,512,512,1)r2t(docphoto,1.0)";
(_d displayCtrl 74307) ctrlSetText "";
while { !isNull _d && {!isNull _unit} } do {
    private _head = _unit selectionPosition "head";
    _cam camSetPos (_unit modelToWorldVisual (_head vectorAdd [0, 0.65, 0.03]));
    _cam camSetTarget (_unit modelToWorldVisual _head);
    _cam camCommit 0;
    uiSleep 0.1;
};
camDestroy _cam;
