-------------------------------------------------------User story 1 :------------------------------------------

-- Création de la base de données
CREATE DATABASE site_info
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Sélectionner la base de données pour les commandes suivantes (si vous exécutez le script pas à pas)
 USE site_info; 



-- Table des jeux (définie en premier pour les clés étrangères)
CREATE TABLE jeu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE -- Ajouté NOT NULL et UNIQUE pour le nom
);



-- Table des utilisateurs
CREATE TABLE users (
    id_user INT AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE, -- Recommandé: email unique
    pseudo VARCHAR(100) NOT NULL UNIQUE, -- Recommandé: pseudo unique
    password VARCHAR(255) NOT NULL, -- Recommandé: Augmenter la taille pour les hashs de mots de passe
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
-- Création de la table jeu--
CREATE TABLE jeu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

    );    



-- Partie Emma
-- ======================= User story 9 ==================

INSERT INTO Message (game_id, user_id, message)
VALUES (1, 3, "Prêt pour une partie ?");

-- ======================= User story 10 ==================
SELECT 
    m.message AS contenu_message,
    u.pseudo AS auteur,
    m.created_at AS date_message,
    CASE 
        WHEN m.user_id = 2 THEN TRUE 
        ELSE FALSE 
    END AS isSender
FROM Message m
JOIN Utilisateur u ON m.user_id = u.id
WHERE m.created_at >= NOW() - INTERVAL 1 DAY
ORDER BY m.created_at ASC;
