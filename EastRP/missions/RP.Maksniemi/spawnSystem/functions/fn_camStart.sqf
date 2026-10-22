/* SPN_fnc_camStart : caméra cinématique qui orbite doucement autour du point */
if (!isNull SPN_cam) exitWith {};
SPN_cam = "camera" camCreate (getPosATL player);
SPN_cam cameraEffect ["INTERNAL", "BACK"];
SPN_cam camSetFov 0.7;
showCinemaBorder false;
SPN_camLast = diag_tickTime;
SPN_camSpeed = getNumber (missionConfigFile >> "SPN_Settings" >> "orbitSpeed");

SPN_camEH = addMissionEventHandler ["EachFrame", {
    if (isNull SPN_cam) exitWith {};
    private _dt = diag_tickTime - SPN_camLast;
    SPN_camLast = diag_tickTime;
    SPN_camAngle = (SPN_camAngle + SPN_camSpeed * _dt) mod 360;
    private _c = SPN_camCenter;
    // petite oscillation verticale pour un rendu plus vivant
    private _h = SPN_camHeight + 1.2 * sin (diag_tickTime * 20);
    SPN_cam camSetPos [
        (_c select 0) + SPN_camDist * sin SPN_camAngle,
        (_c select 1) + SPN_camDist * cos SPN_camAngle,
        (_c select 2) + _h
    ];
    SPN_cam camSetTarget [_c select 0, _c select 1, (_c select 2) + 2];
    SPN_cam camCommit 0;
}];
