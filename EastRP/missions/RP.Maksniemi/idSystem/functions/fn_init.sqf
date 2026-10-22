/* DOC_fnc_init (postInit) */
if (isServer) then {
    DOC_usedNums = profileNamespace getVariable ["DOC_usedNums", []];
};
if (!hasInterface) exitWith {};

DOC_identity      = [];      // données d'identité du joueur (voir README pour l'ordre des index)
DOC_identityReady = false;
DOC_identityMsg   = "";
DOC_photoCam      = objNull;
DOC_photoToken    = 0;
DOC_dblLock       = 0;
DOC_formResult    = "";
DOC_photoCam      = objNull;
DOC_dbg           = [];
DOC_lastClick     = [0, "", controlNull];
DOC_lastTrigger   = 0;
DOC_debug         = false;   // passe à false quand tout fonctionne (messages de diagnostic)

// Branchement sur le module SPN : étape obligatoire avant le spawn
if (isNil "SPN_preSpawnHooks") then { SPN_preSpawnHooks = []; };
SPN_preSpawnHooks pushBack DOC_fnc_registrationHook;

// Après le spawn : donner les documents
[missionNamespace, "SPN_spawned", { _this call DOC_fnc_onSpawned; }] call BIS_fnc_addScriptedEventHandler;
// Après restauration de l'équipement sauvegardé (module CORE) : s'assurer que les papiers sont bien dans l'inventaire
[missionNamespace, "CORE_loadoutApplied", { [_this select 0] call DOC_fnc_giveItems; }] call BIS_fnc_addScriptedEventHandler;

// Surveille l'ouverture de l'inventaire (sans dépendre d'un EH sur l'unité : survit aux changements d'unité)
[] spawn {
    disableSerialization;
    while { true } do {
        waitUntil { uiSleep 0.2; !isNull findDisplay 602 };
        call DOC_fnc_inventoryHook;
        waitUntil { uiSleep 0.1; isNull findDisplay 602 };
    };
};

// Interactions avec un joueur proche (module INT) : montrer ses papiers
["doc_show_id", "Montrer ma carte d'identité", "player", { count DOC_identity > 0 }, { params ["_t"]; [player, _t, "id"] remoteExec ["DOC_fnc_srvShowTo", 2]; }, 20] call INT_fnc_registerAction;
["doc_show_lic", "Montrer mon permis de conduire", "player", { count DOC_identity > 14 && {(DOC_identity select 11) != ""} }, { params ["_t"]; [player, _t, "licence"] remoteExec ["DOC_fnc_srvShowTo", 2]; }, 21] call INT_fnc_registerAction;

// Test en solo (devMode) : se montrer sa propre carte par le même chemin serveur que pour un autre joueur
if (getNumber (missionConfigFile >> "CORE_Settings" >> "devMode") == 1) then {
    ["doc_test_self", "Test : me montrer ma carte", "object", { count DOC_identity > 0 }, { [player, player, "id"] remoteExec ["DOC_fnc_srvShowTo", 2]; }, 95] call INT_fnc_registerAction;
};
