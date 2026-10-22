// Whitelist remoteExec du module DOC (à inclure dans CfgRemoteExec >> Functions)
class DOC_fnc_srvRegister   { allowedTargets = 2; };   // serveur uniquement
class DOC_fnc_srvGet        { allowedTargets = 2; };
class DOC_fnc_clientReceive { allowedTargets = 0; };
class DOC_fnc_srvShowTo     { allowedTargets = 2; };
class DOC_fnc_clientShowFrom { allowedTargets = 0; };
