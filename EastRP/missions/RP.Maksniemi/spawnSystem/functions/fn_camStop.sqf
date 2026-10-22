/* SPN_fnc_camStop : détruit la caméra proprement */
if (SPN_camEH >= 0) then { removeMissionEventHandler ["EachFrame", SPN_camEH]; SPN_camEH = -1; };
if (!isNull SPN_cam) then {
    SPN_cam cameraEffect ["TERMINATE", "BACK"];
    camDestroy SPN_cam;
    SPN_cam = objNull;
};
