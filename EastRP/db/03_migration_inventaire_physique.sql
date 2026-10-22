-- A exécuter UNIQUEMENT si tu avais déjà créé la table players avec l'ancienne version (colonne "items").
USE eastrp;
ALTER TABLE players DROP COLUMN items;
ALTER TABLE players ADD COLUMN loadout MEDIUMTEXT NULL AFTER bank;
ALTER TABLE players ADD COLUMN dir FLOAT NOT NULL DEFAULT 0 AFTER pos;
