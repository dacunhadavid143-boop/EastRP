/* État des images du téléphone. Renvoie [trouvées, total, liste des manquantes] */
private _all = ["frame_ca","screen_ca","wall0_ca","wall1_ca","wall2_ca","iconbase_ca","dock_ca","island_ca","homebar_ca",
                "glyph_phone_ca","glyph_messages_ca","glyph_bank_ca","glyph_settings_ca","glyph_admin_ca"];
private _missing = _all select { ([_x] call PHN_fnc_img) == "" };
[(count _all) - (count _missing), count _all, _missing]
