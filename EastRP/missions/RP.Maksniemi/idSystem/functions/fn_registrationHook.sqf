/* Hook SPN_preSpawnHooks : renvoie true si le joueur a une identité valide et peut spawn */
params ["_point"];
private _profile = [profileName] call DOC_fnc_normName;

// 1) Demande au serveur si une identité existe déjà pour ce joueur
DOC_identityReady = false;
[player] remoteExec ["DOC_fnc_srvGet", 2];
private _t = diag_tickTime + 10;
waitUntil { DOC_identityReady || diag_tickTime > _t };
if (!DOC_identityReady) exitWith { systemChat "[DOC] Serveur injoignable, réessayez."; false };

// 2) Identité existante et cohérente avec le nom de profil : pas de formulaire
if (getNumber (missionConfigFile >> "DOC_Settings" >> "testMode") == 0 && {count DOC_identity > 0} && { ((DOC_identity select 0) + " " + (DOC_identity select 1)) == _profile }) exitWith { true };

// 3) Sinon : formulaire de demande
DOC_formResult = "";
createDialog "DOC_FormDialog";
waitUntil { !isNull findDisplay 74200 };
waitUntil { isNull findDisplay 74200 };
(DOC_formResult == "signed")
