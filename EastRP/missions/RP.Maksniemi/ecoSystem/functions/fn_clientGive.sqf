/* CLIENT : remet les objets achetés (envoyé par le serveur après paiement). Si l'inventaire est plein, ils sont posés au sol. params: [objet, quantité, nom] */
params ["_item", "_qty", "_name"];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
private _isMag = isClass (configFile >> "CfgMagazines" >> _item);
if (player canAdd [_item, _qty]) then {
    for "_i" from 1 to _qty do { if (_isMag) then { player addMagazine _item; } else { player addItem _item; }; };
} else {
    private _h = createVehicle ["GroundWeaponHolder", getPosATL player, [], 0, "CAN_COLLIDE"];
    if (_isMag) then { _h addMagazineCargoGlobal [_item, _qty]; } else { _h addItemCargoGlobal [_item, _qty]; };
    systemChat "[Boutique] Inventaire plein : l'achat est posé à vos pieds.";
};
