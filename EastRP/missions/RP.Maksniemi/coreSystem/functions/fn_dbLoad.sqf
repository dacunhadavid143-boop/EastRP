/* COUCHE STOCKAGE : charge les données d'un joueur. params: [uid] -> tableau de paires [[clé,valeur],...] ou []
   Convertit aussi l'ancien format erroné [[clés...],[valeurs...]] (sauvegardes faites avant le correctif). */
params ["_uid"];
private _d = profileNamespace getVariable [format ["CORE_p_%1", _uid], []];
if !(_d isEqualType []) exitWith { [] };
if (count _d == 2
    && {(_d select 0) isEqualType []} && {(_d select 1) isEqualType []}
    && {count (_d select 0) > 2} && {count (_d select 0) == count (_d select 1)}
    && {((_d select 0) findIf { !(_x isEqualType "") }) == -1}) then {
    private _k = _d select 0;
    private _v = _d select 1;
    private _p = [];
    for "_i" from 0 to (count _k - 1) do { _p pushBack [_k select _i, _v select _i]; };
    diag_log format ["[CORE] Ancienne sauvegarde convertie pour %1 (%2 valeurs)", _uid, count _p];
    _d = _p;
};
_d select { _x isEqualType [] && {count _x == 2} && {(_x select 0) isEqualType ""} }
