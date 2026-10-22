-- A exécuter dans la base eastrp (nouvelle installation)
USE eastrp;

CREATE TABLE IF NOT EXISTS players (
    uid      VARCHAR(20)  NOT NULL PRIMARY KEY,   -- SteamID64
    name     VARCHAR(64)  NOT NULL DEFAULT '',
    cash     BIGINT       NOT NULL DEFAULT 0,
    bank     BIGINT       NOT NULL DEFAULT 0,
    loadout  MEDIUMTEXT   NULL,                   -- équipement physique (inventaire Arma, texte)
    pos      VARCHAR(100) NULL,                   -- dernière position
    dir      FLOAT        NOT NULL DEFAULT 0,     -- dernière direction
    updated  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
