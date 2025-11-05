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

-- ======================= User story 2 + 3 ==================
-- création du jeu de données

INSERT INTO jeu(name)
    VALUES('Power of Memory');

INSERT INTO users(email,password,pseudo)
    VALUES ('alice@example.com','passAlice123','AliceCF'),
        ('bob@example.com', 'passBob456', 'BobTheBuilder'),
        ('carol@example.com', 'carolPass789', 'Carol88'),
        ('dave@example.com', 'daveSecure321', 'DaveD'),
        ('eve@example.com', 'eve123Pass', 'EveE');


INSERT INTO score (id_user, game_id, difficulty, game_score) 
    VALUES
        (1, 1, '1', 450),
        (2, 1, '2', 720),
        (3, 1, '1', 500),
        (4, 1, '3', 950),
        (5, 1, '2', 670),
        (1, 1, '3', 880),
        (2, 1, '1', 410),
        (3, 1, '3', 970),
        (4, 1, '2', 650),
        (5, 1, '1', 400),
        (1, 1, '2', 720),
        (2, 1, '3', 930),
        (3, 1, '1', 480),
        (4, 1, '3', 990),
        (5, 1, '2', 710),
        (1, 1, '1', 500),
        (2, 1, '2', 680),
        (3, 1, '3', 940),
        (4, 1, '1', 460),
        (5, 1, '2', 750);

INSERT INTO message (game_id, id_user, text_message) 
VALUES
        (1, 1, 'Salut à tous !'),
        (1, 2, 'Salut Alice ! Prêt pour jouer ?'),
        (1, 3, 'On lance une partie ?'),
        (1, 4, 'Oui, je suis chaud !'),
        (1, 5, 'Allons-y !'),
        (2, 1, 'Bon courage à tous 😄'),
        (2, 3, 'J’espère battre mon record !'),
        (2, 2, '950 points la dernière fois 💪'),
        (2, 4, 'Impressionnant !'),
        (2, 5, 'On verra ça !'),
        (3, 2, 'Partie terminée !'),
        (3, 1, 'J’ai fait 450 points 😅'),
        (3, 3, 'Moi 500, pas mal !'),
        (3, 4, '950 ! 🏆'),
        (3, 5, 'Bravo Diana !'),
        (4, 4, 'Merci 😁'),
        (4, 3, 'Nouvelle partie ?'),
        (4, 2, 'Ok go'),
        (4, 5, 'Je relance'),
        (4, 1, 'C’est parti !'),
        (5, 2, 'Score battu 😎'),
        (5, 3, 'GG !'),
        (5, 4, 'Vous jouez trop vite 😅'),
        (5, 5, 'Haha merci'),
        (5, 1, 'À plus tard tout le monde 👋');



-- ======================= User story 4 ==================
-- mise à jours du mpd et du mail



UPDATE users
    SET password = @new_mdp
    WHERE id_client = @id_entry ;


UPDATE users
    SET email = @new_email
    WHERE id_client = @id_entry AND password = @new_mdp and @new_email NOT IN (SELECT email FROM users);



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


