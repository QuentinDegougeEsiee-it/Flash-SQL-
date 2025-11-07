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
-- ======================= User story 2 ==================
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


-- ======================= User story 3 ==================
-- a requête SQL qui permettra d’enregistrer un utilisateur dans la table utilisateurs

INSERT INTO users(email,password,pseudo)
    VALUES (@new_user_email,@new_user_password, @new_user_pseudo);



-- ======================= User story 4 ==================
-- mise à jours du mpd et du mail



UPDATE users
    SET password = @new_mdp
    WHERE id_user = @id_entry ;


UPDATE users
    SET email = @new_email
    WHERE id_user = @id_entry AND password = @old_mdp and @new_email NOT IN (SELECT email FROM users);


-- ======================= User story 5 ==================
-- requète identifiant

SELECT  id_user , email, password FROM users
    WHERE email = @given_email
        AND password = @given_password;




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

--Story 8--
@difficulty_s8 = '2';
@game_id_s8 = 'Memory';
@id_user_s8 = 2;
@game_score_s8 = 800;
INSERT INTO score (id_user, game_id, difficulty,game_score) VALUES (@id_user_s8, @game_id_s8, @difficulty_s8, @game_score_s8);






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

-- ======================= User story 11 ==================
--  == création de la table “Messages privés”

CREATE TABLE message_prive (
    id INT AUTO_INCREMENT,
    user_sender_id INT NOT NULL,
    user_receiver_id INT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    read_at DATETIME DEFAULT NULL,
    PRIMARY KEY(id)
) ENGINE=InnoDB;

    ALTER TABLE message_prive
    ADD FOREIGN KEY (user_sender_id) REFERENCES users(id_user),
    ADD FOREIGN KEY (user_receiver_id) REFERENCES users(id_user);







-- ======================= User story 12 ==================
-- ====== Ajout de 5 utilisateurs pour les tests=======
INSERT INTO users (email, pseudo, password) VALUES
('alice@email.com', 'Alice', 'azerty123'),
('bob@email.com', 'Bob', 'qwerty123'),
('charlie@email.com', 'Charlie', 'pass123'),
('diana@email.com', 'Diana', 'hello123'),
('eva@email.com', 'Eva', 'test123');


-- ======= Insertion de 20 messages simulant des conversations privées =======
INSERT INTO message_prive (user_sender_id, user_receiver_id, message, created_at)
VALUES
(1, 2, 'Salut Bob, tu es dispo pour une partie ?', '2025-10-01 10:05:00'),
(2, 1, 'Oui, je lance le jeu !', '2025-10-01 10:06:00'),
(1, 2, 'Ok parfait !', '2025-10-01 10:07:00'),
(3, 1, 'Salut Alice, tu peux m’expliquer une règle ?', '2025-10-02 14:12:00'),
(1, 3, 'Bien sûr, laquelle ?', '2025-10-02 14:13:00'),
(3, 1, 'Sur le système de score !', '2025-10-02 14:14:00'),
(4, 2, 'Salut Bob, tu joues ce soir ?', '2025-10-03 18:30:00'),
(2, 4, 'Oui, vers 20h !', '2025-10-03 18:31:00'),
(4, 2, 'Cool, à tout à l’heure !', '2025-10-03 18:32:00'),
(1, 4, 'Hey Diana, bien joué pour ta dernière partie !', '2025-10-04 09:10:00'),
(4, 1, 'Merci Alice ', '2025-10-04 09:12:00'),
(3, 2, 'Bob, tu es sur le serveur ?', '2025-10-04 20:00:00'),
(2, 3, 'Oui, je viens d’arriver', '2025-10-04 20:01:00'),
(3, 2, 'Parfait, on démarre ?', '2025-10-04 20:02:00'),
(2, 3, 'Go !', '2025-10-04 20:03:00'),
(1, 3, 'Charlie, t’as vu le nouveau mode ?', '2025-10-05 11:05:00'),
(3, 1, 'Oui, il est top !', '2025-10-05 11:06:00'),
(4, 3, 'Salut Charlie, tu veux rejoindre notre groupe ?', '2025-10-06 16:00:00'),
(3, 4, 'Avec plaisir !', '2025-10-06 16:05:00'),
(1, 2, 'GG pour ta victoire Bob !', '2025-10-06 19:30:00');



--====== Création (insertion) d’un nouveau message privé =========
INSERT INTO message_prive (user_sender_id, user_receiver_id, message)
VALUES (1, 2, 'Salut Bob, encore une partie ?');

-- Modification du contenu d’un message ===========
UPDATE message_prive
SET message = 'Salut Bob, encore une partie ce soir ?'
WHERE id = 1
  AND user_sender_id = 1;

-- ========== Suppression d’un message ==========
DELETE FROM message_prive
WHERE id = 3
  AND user_sender_id = 1;

-- ====Vérification cohérence pour les tests ultérieurs =====
-- === voir toutes les conversations ===
SELECT 
    mp.id,
    u1.pseudo AS expediteur,
    u2.pseudo AS destinataire,
    mp.message,
    mp.is_read,
    mp.created_at
FROM message_prive mp
JOIN users u1 ON mp.user_sender_id = u1.id_user
JOIN users u2 ON mp.user_receiver_id = u2.id_user
ORDER BY mp.created_at ASC;

-- === Voir les messages envoyés ou reçus par un utilisateur
SELECT * FROM message_prive
WHERE user_sender_id = 1 OR user_receiver_id = 1;

-- == Voir les utilisateurs sans messages ==
SELECT u.id_user, u.pseudo FROM users
LEFT JOIN message_prive mp
ON u.id_user = mp.user_sender_id OR u.id_user = mp.user_receiver_id
WHERE mp.id IS NULL;




-- ======================= User story 14 ==================
-- permettant d’afficher un échange entre deux utilisateurs

SELECT  message, 
        user_sender_id, 
        user_receiver_id, 
        created_at, 
        read_at, 
        is_read, 
        (SELECT id_user, COUNT(*) As sender_games  
            FROM score
            WHERE id_user = user_sender_id 
            GROUP BY id_user )
        
        (SELECT id_user, COUNT(*) As receiver_games  
            FROM score
            WHERE id_user = user_receiver_id 
            GROUP BY id_user )
        
        (SELECT id_user, COUNT(*) As sender_most_played_games  
            FROM score
            WHERE id_user = user_sender_id 
            GROUP BY id_user )
        
        (SELECT id_user, COUNT(*) As receiver_most_played_games  
            FROM score
            WHERE id_user = user_receiver_id 
            GROUP BY id_user )
            
    FROM message_prive
    WHERE user_sender_id = @user_talking_1 OR user_sender_id = @user_talking_2
        AND user_receiver_id = @user_talking_1 OR user_receiver_id = @user_talking_2
    ORDER BY Year(created_at), MONTH(created_at) ASC





















-- ======================= User story 15 ==================
-- permettra d’afficher toutes les stats de tous les joueur en fonction d’une année


SELECT
    Year(score.created_at) AS Année,
    MONTH(score.created_at) As Mois,

    (SELECT u1.pseudo
        FROM score s1 
        JOIN users u1 ON s1.id_user = u1.id_user
        WHERE Year(s1.created_at) = Year(score.created_at)
            AND MONTH(s1.created_at) = MONTH(score.created_at)
        ORDER BY s1.game_score DESC
         LIMIT 1) AS Top_1,

    (SELECT u2.pseudo
        FROM score s2
        JOIN users u2 ON s2.id_user = u2.id_user
        WHERE Year(s2.created_at) = Year(score.created_at)
            AND MONTH(s2.created_at) = MONTH(score.created_at)
        ORDER BY s2.game_score DESC
         LIMIT 1 offset 1) AS Top_2,
    
    (SELECT u3.pseudo
        FROM score s3
        JOIN users u3 ON s3.id_user = u3.id_user
        WHERE Year(s3.created_at) = Year(score.created_at)
            AND MONTH(s3.created_at) = MONTH(score.created_at)
        ORDER BY s3.game_score DESC
         LIMIT 1 offset 2) AS Top_3,

    COUNT(score.id) AS Total_parties,

    (SELECT name FROM jeu ) As Jeu_le_plus_joué

FROM score 
WHERE YEAR(score.created_at) = 2025
GROUP BY YEAR(score.created_at), MONTH(score.created_at)
ORDER BY YEAR(score.created_at), MONTH(score.created_at);


-- ======================= User story 16  ==================
SELECT
    YEAR(score.created_at) AS 'Année',
    MONTH(score.created_at) AS 'Mois',
    COUNT(*) AS 'Total parties', 
    AVG(score.game_score) AS 'Score moyen'
FROM
    score
    
WHERE
    score.id_user = 1
    AND score.created_at >= '2025-01-01'
    AND score.created_at < '2026-01-01'
GROUP BY
    YEAR(score.created_at), MONTH(score.created_at)
ORDER BY
    Mois ASC; 