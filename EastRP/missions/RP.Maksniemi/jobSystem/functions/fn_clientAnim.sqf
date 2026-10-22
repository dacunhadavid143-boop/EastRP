/* CLIENT (tous) : joue une animation de travail sur un joueur, ou le relève ("" = fin : à genoux puis debout). Envoyé par le serveur. params: [unit, animation] */
params ["_unit", "_anim"];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
if (isNull _unit) exitWith {};
if (_anim != "") then {
    _unit switchMove _anim;
} else {
    if ((toLower animationState _unit) find "eastrp_" == 0) then {
        _unit switchMove "AmovPknlMstpSnonWnonDnon";
        if (local _unit) then { _unit playMoveNow "AmovPercMstpSnonWnonDnon"; };
    };
};
