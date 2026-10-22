/* Validation + envoi de la demande. À appeler avec spawn. */
disableSerialization;
private _d = findDisplay 74200;
if (isNull _d) exitWith {};
private _err = _d displayCtrl 74222;
private _profile = [profileName] call DOC_fnc_normName;

// Signature = nom de profil
private _sig = [ctrlText (_d displayCtrl 74221)] call DOC_fnc_normName;
if !(_sig == _profile) exitWith { _err ctrlSetText "Signature invalide : saisissez exactement votre nom et prénom."; };

private _ids = [74213,74214,74215,74216,74217,74218,74219,74220];
private _in = _ids apply { lbCurSel (_d displayCtrl _x) };
_in params ["_sexI","_dayI","_monI","_yearI"];

// Date réaliste
private _year = (systemTime select 0) - 18 - _yearI;
if ((_dayI + 1) > ([_monI + 1, _year] call DOC_fnc_daysInMonth)) exitWith { _err ctrlSetText "Date de naissance invalide pour ce mois."; };

// Majorité
private _now = systemTime;
private _age = (_now select 0) - _year;
if (_monI + 1 > (_now select 1) || {_monI + 1 == (_now select 1) && {_dayI + 1 > (_now select 2)}}) then { _age = _age - 1; };
if (_age < 18) exitWith { _err ctrlSetText "Vous devez être majeur(e) pour déposer cette demande."; };

_err ctrlSetText "Traitement de la demande...";
(_d displayCtrl 74223) ctrlEnable false;
DOC_identityReady = false;
[player, _in] remoteExec ["DOC_fnc_srvRegister", 2];

private _t = diag_tickTime + 10;
waitUntil { DOC_identityReady || diag_tickTime > _t || isNull _d };
if (isNull _d) exitWith {};

if (DOC_identityReady && {count DOC_identity > 0}) then {
    DOC_formResult = "signed";
    closeDialog 1;
} else {
    (_d displayCtrl 74223) ctrlEnable true;
    _err ctrlSetText (if (DOC_identityMsg != "") then { DOC_identityMsg } else { "Le serveur n'a pas répondu, réessayez." });
};
