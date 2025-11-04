CREATE DATABASE site_info
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

CREATE TABLE users (
    id_user INT AUTO_INCREMENT,
    email VARCHAR(100),
    pseudo VARCHAR(100),
    password VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id_user)
    );

CREATE TABLE score (
    id INT AUTO_INCREMENT,
    id_user INT,
    game_id INT ,
    difficulty ENUM('1', '2', '3'),
    game_score INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY (id_user) REFERENCES users(id_user)
    );