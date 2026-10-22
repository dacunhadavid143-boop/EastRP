/* CLIENT : un joueur proche nous montre ses papiers (envoyé par le serveur). params: [type, données, porteur] */
params ["_type", "_data", "_holder"];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
systemChat format ["[Papiers] %1 vous montre sa %2.", name _holder, if (_type == "id") then { "carte d'identité" } else { "permis de conduire" }];
[_type, _data, _holder] spawn DOC_fnc_showCard;
