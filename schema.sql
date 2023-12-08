-- >> Creating `users` tables

CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(32) CHECK (LENGTH(`username`) >= 5) NOT NULL UNIQUE,
    `password` VARCHAR(128) NOT NULL,
    `is_staff` BOOL DEFAULT FALSE,
    `is_superuser` BOOL DEFAULT FALSE,
    `is_active` BOOL NOT NULL DEFAULT TRUE,
    `last_login_date` TIMESTAMP,
    `join_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_users_users_username_password` (`username`, `password`)
);

CREATE TABLE `profiles` (
    `user_id` INT PRIMARY KEY,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32),
    `bio` VARCHAR(128),
    `picture` BLOB,
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
);

-- >> Creating schema `products` tables

CREATE TABLE `categories` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL UNIQUE,
    slug VARCHAR(128) NOT NULL UNIQUE,
    is_active BOOL NOT NULL DEFAULT TRUE
);

CREATE TABLE `products` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` TEXT NOT NULL,
    `description` LONGTEXT NOT NULL,
    `category_id` INT,
    `is_active` BOOL NOT NULL DEFAULT TRUE,
    FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
);

CREATE TABLE `properties` (
    `product_id` INT NOT NULL,
    `property_name` VARCHAR(16) NOT NULL,
    `property_value` TEXT NOT NULL,
    `price` FLOAT NOT NULL,
    `count` INT NOT NULL,
    FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
    INDEX `idx_products_properties_product_id` (`product_id`)
);

-- >> Creating schema `orders` tables

CREATE TABLE `addresses` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `address` TEXT NOT NULL
);

CREATE TABLE `orders` (
    `user_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `date` TIMESTAMP NOT NULL,
    `address_id` INT NOT NULL,
    `is_done` BOOL NOT NULL DEFAULT FALSE,
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
    FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`),
    INDEX `idx_orders_orders_user_id` (`user_id`)
);
