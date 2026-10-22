/* CLIENT : affiche les ESPÈCES dans la barre de titre de l'inventaire (à gauche de la croix de fermeture), mis à jour en direct.
   (L'argent de la banque n'apparaît que dans le téléphone.) La barre est retrouvée par le nom du joueur ; sinon coin de secours. */
disableSerialization;
private _cfg = missionConfigFile >> "CORE_Settings";
private _sym = getText (_cfg >> "currencySymbol");
private _corner = getText (_cfg >> "invMoneyCorner");
if (_corner == "") then { _corner = "topright"; };

while { true } do {
    waitUntil { uiSleep 0.2; !isNull findDisplay 602 };
    private _d = findDisplay 602;
    uiSleep 0.2;                                           // laisse l'inventaire finir de se construire
    private _name = name player;
    private _all = [_d] call CORE_fnc_deepControls;

    // 1) contrôle qui porte le nom du joueur (titre du panneau de droite)
    private _hdr = controlNull;
    {
        if (isNull _hdr && {ctrlType _x != 15}) then {
            private _t = ctrlText _x;
            if (_t != "" && {(_t find _name) >= 0}) then { _hdr = _x; };
        };
    } forEach _all;

    private _pos = [];
    private _bar = false;
    if (!isNull _hdr) then {
        private _hp = ctrlPosition _hdr;
        private _right = (_hp select 0) + (_hp select 2);
        // 2) bord droit de la barre : plus large contrôle de la même ligne qui englobe le titre
        {
            private _p = ctrlPosition _x;
            if (_x != _hdr && {ctrlType _x != 15} && {abs ((_p select 1) - (_hp select 1)) < 0.02}
                && {(_p select 0) <= (_hp select 0) + 0.003} && {((_p select 0) + (_p select 2)) >= _right - 0.003}) then {
                _right = _right max ((_p select 0) + (_p select 2));
            };
        } forEach _all;
        // 3) bouton de fermeture (petit contrôle à droite, même ligne) : on s'arrête avant lui
        {
            private _p = ctrlPosition _x;
            if (_x != _hdr && {ctrlType _x != 15} && {abs ((_p select 1) - (_hp select 1)) < 0.02} && {(_p select 2) < 0.06}
                && {(_p select 0) > (_hp select 0) + 0.05} && {(_p select 0) < _right}) then {
                _right = _p select 0;
            };
        } forEach _all;
        private _w = 0.20;
        _pos = [_right - _w - 0.006, _hp select 1, _w, _hp select 3];
        _bar = true;
    } else {
        _pos = [_corner, 0.30, 0.045] call CORE_fnc_cornerPos;
    };
    diag_log format ["[CORE] invMoney : barre de titre %1, position %2", if (_bar) then {"trouvée"} else {"introuvable (coin de secours)"}, _pos];

    private _c = _d ctrlCreate ["CORE_RscStructuredText", 74401];
    _c ctrlSetPosition _pos;
    if (!_bar) then { _c ctrlSetBackgroundColor [0, 0, 0, 0.55]; };
    _c ctrlCommit 0;
    while { !isNull _d } do {
        _c ctrlSetStructuredText parseText format [
            "<t align='right' size='0.85'>Espèces : <t color='#e6c14d' font='PuristaBold'>%1 %2</t></t>",
            [player getVariable ["CORE_cash", 0]] call CORE_fnc_fmt,
            _sym
        ];
        uiSleep 0.3;
    };
};
