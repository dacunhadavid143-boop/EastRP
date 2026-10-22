/* Classe d'objet d'une ligne de liste d'inventaire. params: [control, ligne] */
params ["_c", "_row"];
private _cls = "";
if (_row < 0) exitWith { "" };
switch (ctrlType _c) do {
    case 102: {
        private _cols = (lnbSize _c) select 1;
        for "_k" from 0 to (_cols - 1) do {
            private _d = _c lnbData [_row, _k];
            if (_d != "") exitWith { _cls = _d; };
        };
        if (_cls == "") then { _cls = _c lbData _row; };
    };
    case 5: { _cls = _c lbData _row; };
};
_cls
