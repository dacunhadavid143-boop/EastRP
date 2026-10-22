/* SERVEUR : initialisation du téléphone (numéros, canaux d'appel, événements) */
if (!isServer) exitWith {};
private _cfg = missionConfigFile >> "PHN_Settings";
PHN_used    = profileNamespace getVariable ["PHN_usedNumbers", []];
PHN_calls   = createHashMap;     // "c<id>" -> [appelant, appelé, état, canal]
PHN_callSeq = 0;
PHN_pool    = [];
// Profils du chat : numéro -> [nom, avatar, info]. Accepte le format paires [[numéro, profil], ...]
// et convertit l'ancien format erroné [[numéros...], [profils...]].
private _wp = profileNamespace getVariable ["PHN_wa_profiles", []];
if !(_wp isEqualType []) then { _wp = []; };
if (count _wp == 2 && {(_wp select 0) isEqualType []} && {(_wp select 1) isEqualType []}
    && {count (_wp select 0) == count (_wp select 1)}
    && {((_wp select 0) findIf { _x isEqualType [] }) == -1}) then {
    private _k = _wp select 0;
    private _v = _wp select 1;
    _wp = [];
    for "_i" from 0 to (count _k - 1) do { _wp pushBack [_k select _i, _v select _i]; };
    diag_log format ["[PHN] Anciens profils du chat convertis (%1)", count _wp];
};
PHN_profiles = createHashMapFromArray (_wp select { _x isEqualType [] && {count _x == 2} });
PHN_statuses = profileNamespace getVariable ["PHN_wa_status", []];                                // [numéro, texte, couleur, minute]                // canaux radio personnalisés réutilisables : [id, occupé]

for "_i" from 1 to (getNumber (_cfg >> "callChannels")) do {
    private _id = radioChannelCreate [[0.30, 0.90, 0.40, 1], format ["Appel %1", _i], "%UNIT_NAME", []];
    if (_id > 0) then { PHN_pool pushBack [_id, false]; };
};
diag_log format ["[PHN] %1 canal(aux) d'appel créé(s)", count PHN_pool];

// Joueur chargé par le noyau : numéro, rôle, messages
[missionNamespace, "CORE_playerLoaded", { _this call PHN_fnc_srvOnLoaded; }] call BIS_fnc_addScriptedEventHandler;

// Fin d'appel si un participant se déconnecte ou meurt
addMissionEventHandler ["HandleDisconnect", {
    params ["_u"];
    private _id = _u getVariable ["PHN_callId", -1];
    if (_id >= 0) then { [_id, "L'interlocuteur s'est déconnecté."] call PHN_fnc_srvEndCall; };
    false
}];
addMissionEventHandler ["EntityKilled", {
    params ["_u"];
    private _id = _u getVariable ["PHN_callId", -1];
    if (_id >= 0) then { [_id, "Appel interrompu."] call PHN_fnc_srvEndCall; };
}];
