/* "5551234" -> "555-1234". params: [numéro] */
params [["_n", ""]];
if (count _n == 7) then { (_n select [0, 3]) + "-" + (_n select [3, 4]) } else { _n }
