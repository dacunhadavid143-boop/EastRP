/* SERVEUR : enregistre une identité. params: [unit, [indices du formulaire]] */
if (!isServer) exitWith {};
params [["_unit", objNull, [objNull]], ["_in", [], [[]]]];
private _ro = remoteExecutedOwner;
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if (_ro != 0 && {_ro != owner _unit}) exitWith { diag_log format ["[DOC] Requête refusée (propriétaire %1 != %2)", _ro, owner _unit]; };

private _fail = { params ["_m"]; [[], _m] remoteExec ["DOC_fnc_clientReceive", _unit]; };
private _cfg = missionConfigFile >> "DOC_Settings";
private _key = format ["DOC_id_%1", getPlayerUID _unit];

// Nom = nom de profil du joueur (pas celui envoyé par le client)
private _n = [name _unit] call DOC_fnc_parseName;
if (_n isEqualTo []) exitWith { ["Nom de profil invalide (Prénom Nom requis)."] call _fail; };

// Identité déjà existante et cohérente : on la renvoie telle quelle (pas de re-génération)
private _old = profileNamespace getVariable [_key, []];
if (getNumber (_cfg >> "testMode") == 0 && {count _old > 0} && {((_old select 0) + " " + (_old select 1)) == ((_n select 0) + " " + (_n select 1))}) exitWith {
    [_old, ""] remoteExec ["DOC_fnc_clientReceive", _unit];
};

// Validation des données reçues
if (count _in != 8 || {_in findIf { !(_x isEqualType 0) } != -1}) exitWith { ["Données invalides."] call _fail; };
_in params ["_sexI","_dayI","_monI","_yearI","_placeI","_heightI","_eyeI","_licI"];
private _places = getArray (_cfg >> "birthPlaces");
private _eyes   = getArray (_cfg >> "eyes");
private _cats   = getArray (_cfg >> "licenceCats");
if (_sexI < 0 || _sexI > 1 || _dayI < 0 || _dayI > 30 || _monI < 0 || _monI > 11 || _yearI < 0 || _yearI > 62
 || _placeI < 0 || _placeI >= count _places || _heightI < 0 || _heightI > 55
 || _eyeI < 0 || _eyeI >= count _eyes || _licI < 0 || _licI >= count _cats) exitWith { ["Données hors limites."] call _fail; };

private _now  = systemTime;
private _year = (_now select 0) - 18 - _yearI;
if ((_dayI + 1) > ([_monI + 1, _year] call DOC_fnc_daysInMonth)) exitWith { ["Date de naissance invalide."] call _fail; };
private _age = (_now select 0) - _year;
if (_monI + 1 > (_now select 1) || {_monI + 1 == (_now select 1) && {_dayI + 1 > (_now select 2)}}) then { _age = _age - 1; };
if (_age < 18) exitWith { ["Vous devez être majeur(e)."] call _fail; };

// Génération de numéros de documents de type "est" : 2 lettres + 7 chiffres
private _letters = "ABCEHKMPTXY" splitString "";
private _gen = {
    private _n = (selectRandom _letters) + (selectRandom _letters) + " ";
    for "_i" from 1 to 7 do { _n = _n + str (floor random 10); };
    _n
};
private _idNum = call _gen;
while { _idNum in DOC_usedNums } do { _idNum = call _gen; };
DOC_usedNums pushBack _idNum;

private _cat = _cats select _licI;
private _hasLic = (_cat != "Aucun");
private _licNum = "";
if (_hasLic) then {
    _licNum = call _gen;
    while { _licNum in DOC_usedNums } do { _licNum = call _gen; };
    DOC_usedNums pushBack _licNum;
};
profileNamespace setVariable ["DOC_usedNums", DOC_usedNums];

private _issued = [_now select 2, _now select 1, _now select 0];
private _expY = (_now select 0) + 10;
private _expD = (_now select 2) min ([_now select 1, _expY] call DOC_fnc_daysInMonth);
private _expires = [_expD, _now select 1, _expY];

private _data = [
    _n select 0,                         // 0 prénom
    _n select 1,                         // 1 nom
    ["M","F"] select _sexI,              // 2 sexe
    [_dayI + 1, _monI + 1, _year],       // 3 date de naissance
    _places select _placeI,              // 4 lieu de naissance
    150 + _heightI,                      // 5 taille
    _eyes select _eyeI,                  // 6 yeux
    getText (_cfg >> "nationality"),     // 7 nationalité
    _idNum,                              // 8 n° carte d'identité
    _issued,                             // 9 délivrée le
    _expires,                            // 10 expire le
    if (_hasLic) then { _cat } else { "" }, // 11 catégories permis ("" = pas de permis)
    _licNum,                             // 12 n° permis
    _issued,                             // 13 permis délivré le
    _expires                             // 14 permis expire le
];

profileNamespace setVariable [_key, _data];
saveProfileNamespace;
diag_log format ["[DOC] Identité créée pour %1 (%2)", name _unit, getPlayerUID _unit];
[_data, ""] remoteExec ["DOC_fnc_clientReceive", _unit];
