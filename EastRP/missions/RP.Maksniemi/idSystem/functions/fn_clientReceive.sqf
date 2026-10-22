/* CLIENT : reçoit l'identité du serveur uniquement. params: [data, message] */
params [["_data", []], ["_msg", ""]];
private _ro = remoteExecutedOwner;
if (_ro != 0 && {_ro != 2}) exitWith {};
DOC_identity      = _data;
DOC_identityMsg   = _msg;
DOC_identityReady = true;
