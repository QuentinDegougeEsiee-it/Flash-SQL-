CREATE DATABASE site_info
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

CREATE TABLE users (
    id_user INT AUTO_INCREMENT,
    email VARCHAR(100),
    pseudo VARCHAR(100),
    password VARCHAR(100),
    created_at DATETIME,
    updated_at DATETIME,
    PRIMARY KEY(id_user)
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
