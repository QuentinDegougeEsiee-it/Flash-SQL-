-- --------------------------------------------------------
-- User story 1 : Création de la structure
-- --------------------------------------------------------

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS site_info -- Ajouté IF NOT EXISTS pour éviter une erreur si elle existe déjà
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Sélectionner la base de données pour les commandes suivantes
USE site_info;

-- Table des jeux (définie en premier pour les clés étrangères)
CREATE TABLE jeu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Table des utilisateurs
CREATE TABLE users (
    id_user INT AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    pseudo VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id_user)
);

-- Table des scores 
CREATE TABLE score (
    id INT AUTO_INCREMENT,
    id_user INT NOT NULL,
    game_id INT NOT NULL,
    difficulty ENUM('1', '2', '3') NOT NULL,
    game_score INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY (id_user) REFERENCES users(id_user),
    FOREIGN KEY (game_id) REFERENCES jeu(id)
);

-- Table des messages 
CREATE TABLE message (
    id INT AUTO_INCREMENT,
    game_id INT NOT NULL,
    id_user INT NOT NULL,
    text_message VARCHAR(500) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY (id_user) REFERENCES users(id_user),
    FOREIGN KEY (game_id) REFERENCES jeu(id)
);


-- --------------------------------------------------------
-- Partie Emma : Requêtes corrigées
-- --------------------------------------------------------

-- ======================= User story 9 ==================
-- Insertion d'un message
-- Noms corrigés : table 'message', colonnes 'id_user' et 'text_message'
INSERT INTO message (game_id, id_user, text_message)
VALUES (1, 3, 'Prêt pour une partie ?');


-- ======================= User story 10 ==================
-- Sélection des messages
-- Noms corrigés : tables 'message' et 'users', colonnes 'text_message', 'id_user'
SELECT 
    m.text_message AS contenu_message,
    u.pseudo AS auteur,
    m.created_at AS date_message,
    CASE 
        WHEN m.id_user = 2 THEN TRUE 
        ELSE FALSE 
    END AS isSender
FROM message m
JOIN users u ON m.id_user = u.id_user -- Jointure corrigée
WHERE m.created_at >= NOW() - INTERVAL 1 DAY
ORDER BY m.created_at ASC;