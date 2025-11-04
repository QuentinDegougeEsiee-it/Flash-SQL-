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