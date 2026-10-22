/* SERVEUR : prépare l'étape courante du joueur : point imposé ("random" / "same"), étape « véhicule » sautée si déjà sorti,
   question du mini-jeu ("quiz:..."). params: [unit] */
params ["_unit"];
private _job = [_unit, "job", ""] call CORE_fnc_getValue;
_unit setVariable ["JOB_assigned", ""];
_unit setVariable ["JOB_quizQ", []];
_unit setVariable ["JOB_stepOverride", []];
if (_job == "") exitWith {};
private _lv = [_job, [_unit, _job] call JOB_fnc_getXp] call JOB_fnc_cfgLevel;
private _steps = getArray ((_lv select 1) >> "steps");
if (_steps isEqualTo []) exitWith {};
private _idx = (_unit getVariable ["JOB_step", 0]) min (count _steps - 1);
// Véhicule de service déjà sorti (et intact) : on passe directement à l'étape suivante
if (((_steps select _idx) param [6, ""]) == "vehget" && {alive (_unit getVariable ["JOB_veh", objNull])} && {_idx + 1 < count _steps}) then {
    _idx = _idx + 1;
};
_unit setVariable ["JOB_step", _idx];
private _st = _steps select _idx;
_st params ["_type", "_label", "_dur", ["_mode", "any"]];
private _sp = _st param [6, ""];
// Dépôt de la pompe contrôlée : la destination dépend de la décision prise sur la fiche
if (_sp == "qcDrop") then {
    if ((_unit getVariable ["JOB_qcDecision", 0]) == 1) then {
        _type = "job_usine_rebut";
        _unit setVariable ["JOB_stepOverride", [_type, "Jeter la pompe refusée dans la benne à rebut"]];
    } else {
        _type = "job_usine_expedition";
        _unit setVariable ["JOB_stepOverride", [_type, "Déposer la pompe validée dans la caisse d'expédition"]];
    };
};
switch (_mode) do {
    case "random": {
        private _prev = _unit getVariable ["JOB_lastMarker", ""];
        private _list = [_type] call JOB_fnc_pointList;
        if (count _list > 1) then { _list = _list - [_prev]; };
        if (_list isEqualTo []) then {
            diag_log format ["[JOB] AUCUN point '%1_...' (marqueur ou objet nommé) sur la carte pour le métier %2 : à placer dans l'éditeur", _type, _job];
        } else {
            _unit setVariable ["JOB_assigned", selectRandom _list];
        };
    };
    case "same": {
        private _prev = _unit getVariable ["JOB_lastMarker", ""];
        if ((toLower _prev find toLower _type) == 0) then { _unit setVariable ["JOB_assigned", _prev]; };
    };
};
// Fiche de contrôle d'une pompe : mesures tirées au hasard (une pompe sur deux a un défaut) ; la bonne réponse reste sur le serveur
if (_sp == "quiz:fiche") exitWith {
    private _f = { params ["_v", "_d"]; _v toFixed _d };
    private _a = 40 + (random 0.5) - 0.25;      // A : sortie 40 mm ± 0,3
    private _b = 50 + (random 0.5) - 0.25;      // B : aspiration 50 mm ± 0,3
    private _c = 52 + random 15;                // C : moteur <= 70 °C
    private _p = 3.1 + random 0.8;              // pression d'épreuve >= 3,0 bar
    private _fuite = "Aucune";
    private _bad = random 1 < 0.5;
    if (_bad) then {
        switch (floor random 5) do {
            case 0: { _a = 40 + selectRandom [-1, 1] * (0.4 + random 0.6); };
            case 1: { _b = 50 + selectRandom [-1, 1] * (0.4 + random 0.6); };
            case 2: { _c = 72 + random 12; };
            case 3: { _p = 2.2 + random 0.7; };
            default { _fuite = "Goutte au joint"; };
        };
    };
    private _rows = [
        ["A - Diamètre de sortie",     "40,0 mm ± 0,3",   format ["%1 mm", [_a, 2] call _f]],
        ["B - Diamètre d'aspiration",  "50,0 mm ± 0,3",   format ["%1 mm", [_b, 2] call _f]],
        ["C - Température moteur",     "70 °C maximum",   format ["%1 °C", [_c, 0] call _f]],
        ["Pression d'épreuve",         "3,0 bar minimum", format ["%1 bar", [_p, 1] call _f]],
        ["Fuite au test",              "Aucune",          _fuite]
    ];
    _unit setVariable ["JOB_quizOk", [0, 1] select _bad];
    _unit setVariable ["JOB_quizQ", ["Comparez chaque mesure à sa tolérance. Une seule mesure hors tolérance = pompe défectueuse.",
        ["Valider : pompe conforme (expédition)", "Refuser : pompe défectueuse (rebut)"], _rows]];
};
// Mini-jeu : question tirée au hasard, réponses mélangées ; la bonne réponse reste sur le serveur
if ((_sp find "quiz:") == 0) then {
    private _bank = getArray (missionConfigFile >> "JOB_Quiz" >> (_sp select [5]) >> "questions");
    if (count _bank > 0) then {
        (selectRandom _bank) params ["_txt", "_ans", "_good"];
        private _order = [];
        { _order pushBack _forEachIndex; } forEach _ans;
        _order = _order call BIS_fnc_arrayShuffle;
        _unit setVariable ["JOB_quizOk", _order find _good];
        _unit setVariable ["JOB_quizQ", [_txt, _order apply { _ans select _x }]];
    } else {
        diag_log format ["[JOB] banque de questions vide : JOB_Quiz >> %1", _sp select [5]];
    };
};
