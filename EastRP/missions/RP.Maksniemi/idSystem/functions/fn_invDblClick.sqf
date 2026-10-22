/* EH display "MouseButtonDblClick". params: [display, bouton, ...] */
params ["_disp", "_btn"];
if (_btn != 0) exitWith { false };
[focusedCtrl _disp, -1] call DOC_fnc_invUse
