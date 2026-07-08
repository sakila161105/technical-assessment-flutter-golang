-- =====================================
-- DATABASE MIGRATION
-- Technical Assessment Laundry
-- =====================================


CREATE DATABASE IF NOT EXISTS laundry_db;

USE laundry_db;



-- ==========================
-- TABLE USERS
-- ==========================

CREATE TABLE IF NOT EXISTS users (

    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    email VARCHAR(100) NOT NULL UNIQUE,

    password VARCHAR(255) NOT NULL,

    role VARCHAR(50) DEFAULT 'Owner',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP

);



-- ==========================
-- TABLE ORDERS
-- ==========================

CREATE TABLE IF NOT EXISTS orders (

    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    code VARCHAR(50) NOT NULL UNIQUE,

    customer VARCHAR(100) NOT NULL,

    service VARCHAR(100) NOT NULL,

    price INT NOT NULL DEFAULT 0,

    status VARCHAR(50) DEFAULT 'Diterima',

    payment VARCHAR(50) DEFAULT 'Belum Lunas',

    estimate VARCHAR(100),

    service_count VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP

);