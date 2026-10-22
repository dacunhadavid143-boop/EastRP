-- A exécuter UNE fois (en tant que root). Change le mot de passe avant !
CREATE DATABASE IF NOT EXISTS eastrp CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS 'eastrp'@'localhost' IDENTIFIED BY 'CHANGE_MOI_MOT_DE_PASSE';
GRANT ALL PRIVILEGES ON eastrp.* TO 'eastrp'@'localhost';
FLUSH PRIVILEGES;
