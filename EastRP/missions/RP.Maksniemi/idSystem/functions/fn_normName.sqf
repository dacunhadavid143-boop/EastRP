/* Retire les espaces multiples / de bord. params: [string] */
params [["_s", ""]];
(_s splitString " ") joinString " "
