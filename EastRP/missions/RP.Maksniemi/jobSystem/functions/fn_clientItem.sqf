/* CLIENT : donne ou reprend un objet de travail (pièce, pompe...). Envoyé par le serveur. params: ["add" | "remove", classe] */
params [["_op", ""], ["_cls", ""]];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
if !(isClass (configFile >> "CfgMagazines" >> _cls)) exitWith { diag_log format ["[JOB] objet inconnu : %1 (addon eastrp_core à jour ?)", _cls]; };
private _nom = getText (configFile >> "CfgMagazines" >> _cls >> "displayName");
if (_op == "remove") exitWith { player removeMagazine _cls; };
if (player canAdd _cls) then {
    player addMagazine _cls;
    systemChat format ["[Travail] + %1", _nom];
} else {
    private _h = createVehicle ["GroundWeaponHolder", getPosATL player, [], 0, "CAN_COLLIDE"];
    _h addMagazineCargoGlobal [_cls, 1];
    systemChat format ["[Travail] Inventaire plein : %1 posé(e) à vos pieds.", _nom];
};
