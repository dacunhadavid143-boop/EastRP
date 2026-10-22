/* Ouvre le téléphone */
if (PHN_open) exitWith {};
PHN_open = true;
if !(createDialog "PHN_Phone") then { PHN_open = false; };
