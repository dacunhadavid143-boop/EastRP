/* CLIENT : ouvre la fenêtre du Pôle Emploi, après avoir demandé au serveur l'état à jour (délai de démission, contrat...). À lancer avec spawn. */
if (!isNull findDisplay 75600) exitWith {};
private _old = player getVariable ["JOB_state", []];
[player] remoteExec ["JOB_fnc_srvAskSync", 2];
private _t = time + 1.5;
waitUntil { uiSleep 0.05; time > _t || {(player getVariable ["JOB_state", []]) isNotEqualTo _old} };
uiSleep 0.1;
createDialog "JOB_Pole";
