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


---Partie tristan:----
-- --------------------------------------------------------
-- Story 6 : Afficher les scores (filtrable par jeu et difficulté)
-- --------------------------------------------------------

SET @difficulty_filter_s6 = '2'; 
SET @game_name_filter_s6 = 'Memory';

SELECT
  jeu.name,
  users.pseudo,
  score.difficulty,
  score.game_score,
  score.created_at
FROM
  score
JOIN
  users ON score.id_user = users.id_user
JOIN
  jeu ON score.game_id = jeu.id
WHERE
  
  (jeu.name = @game_name_filter_s6 OR @game_name_filter_s6 IS NULL)
 
  AND (score.difficulty = @difficulty_filter_s6 OR @difficulty_filter_s6 IS NULL)
ORDER BY
  jeu.name ASC, 
  score.difficulty DESC,
  score.game_score DESC; 






  -- Story 7--
SET @difficulty_filter_s7 = NULL;
SET @game_name_filter_s7 = NULL;
SET @pseudo_filter_s7 = 'User'; 

SELECT
  jeu.name,
  users.pseudo,
  score.difficulty,
  score.game_score,
  score.created_at
FROM
  score
JOIN
  users ON score.id_user = users.id_user
JOIN
  jeu ON score.game_id = jeu.id
WHERE
  
  (users.pseudo LIKE CONCAT('%', @pseudo_filter_s7, '%') OR @pseudo_filter_s7 IS NULL)
  
  
  AND (jeu.name = @game_name_filter_s7 OR @game_name_filter_s7 IS NULL)
  AND (score.difficulty = @difficulty_filter_s7 OR @difficulty_filter_s7 IS NULL)
ORDER BY
  jeu.name ASC,
  score.difficulty DESC,
  score.game_score DESC;



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











--Outils-----
INSERT INTO users (email, pseudo, password) VALUES
('utilisateur1@exemple.com', 'User1Pseudo', '$2y$10$XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
('utilisateur2@exemple.com', 'User2Pseudo', '$2y$10$YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY'),
('utilisateur3@exemple.com', 'User3Pseudo', '$2y$10$ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'),
('utilisateur4@exemple.com', 'User4Pseudo', '$2y$10$AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
('utilisateur5@exemple.com', 'User5Pseudo', '$2y$10$BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'),
('utilisateur6@exemple.com', 'User6Pseudo', '$2y$10$CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'),
('utilisateur7@exemple.com', 'User7Pseudo', '$2y$10$DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
('utilisateur8@exemple.com', 'User8Pseudo', '$2y$10$EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'),
('utilisateur9@exemple.com', 'User9Pseudo', '$2y$10$FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'),
('utilisateur10@exemple.com', 'User10Pseudo', '$2y$10$GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG')