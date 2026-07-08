-- =====================================
-- DATABASE SCHEMA
-- Laundry Management System
-- =====================================


CREATE TABLE users (

    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    name VARCHAR(100) NOT NULL,

    email VARCHAR(100) UNIQUE NOT NULL,

    password VARCHAR(255) NOT NULL,

    role VARCHAR(50) DEFAULT 'Owner',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP

);



CREATE TABLE orders (

    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    code VARCHAR(50) UNIQUE NOT NULL,

    customer VARCHAR(100) NOT NULL,

    service VARCHAR(100) NOT NULL,

    price INT DEFAULT 0,

    status VARCHAR(50),

    payment VARCHAR(50),

    estimate VARCHAR(100),

    service_count VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP

);



-- Relasi sederhana

-- users tidak langsung berelasi dengan orders
-- karena sistem menggunakan user login sebagai owner outlet