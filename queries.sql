-- >> Views

-- View for joining `users`, and `profiles`
CREATE VIEW users_view AS
    SELECT * FROM users u
    JOIN profiles p on u.id = p.user_id;

SELECT * FROM users_view;

-- >> SELECT Statements

-- Retrieve all users
SELECT * FROM users;

-- Retrieve users profile by user_id
SELECT * FROM profiles WHERE user_id = 0;

-- Retrieve users profile by username
SELECT * FROM profiles WHERE user_id = (
    SELECT id FROM users WHERE username=''
);

-- Check users authentication (Anti-Injection)
PREPARE `auth`
FROM 'SELECT id FROM users WHERE username = ? AND password = ?';
SET @username = '';
SET @password = '';
EXECUTE `auth` USING @username, @password;

-- Retrieve product inventory
SELECT COUNT(*) FROM properties
WHERE product_id = (
    SELECT id FROM products WHERE name = ''
);

-- Retrieve product properties
SELECT property_name, property_value FROM properties
WHERE product_id = (
    SELECT * FROM products WHERE name = ''
);

-- Retrieve products by category
SELECT * FROM products
WHERE category_id = (
    SELECT id FROM categories
    WHERE name = ''
);

-- Retrieve undone orders
SELECT * FROM orders o
JOIN addresses a on a.id = o.address_id
JOIN products p on p.id = o.product_id
WHERE user_id = (
    SELECT id FROM users
    WHERE username = ''
);

-- Get active users count
SELECT COUNT(*) FROM users
WHERE is_active = TRUE;

-- Get products count
SELECT p.name, SUM(p2.count) AS `count` FROM products p
JOIN properties p2 on p.id = p2.product_id
GROUP BY p.name;

-- Get top 10 most-popular products
SELECT p.name, COUNT(p.id) AS `count` FROM products p
JOIN orders o on p.id = o.product_id
GROUP BY p.name
ORDER BY `count` DESC
LIMIT 10;

-- >> INSERT Statements

-- Insert into user
INSERT INTO users (username, password)
VALUES ('', '');

-- Insert into profile
INSERT INTO profiles (user_id, first_name, last_name, bio, picture)
VALUES (0, '', '', '', '');

-- Insert into category
INSERT INTO categories (name, slug)
VALUES ('', '');

-- Insert into addresses
INSERT INTO addresses (address)
VALUES ('');

-- Insert into products
INSERT INTO products (name, description, category_id)
VALUES ('', '', (
    SELECT id FROM categories WHERE name = ''
));

-- Insert into properties
INSERT INTO properties (product_id, property_name, property_value, price, count)
VALUES (0, '', '', 0.0, 1);

-- Insert into orders
INSERT INTO orders (user_id, product_id, date, address_id)
VALUES (0, 0, '', 0);

-- >> UPDATE Statements

-- De-active user
UPDATE users SET is_active = FALSE
WHERE username = '';

-- Change Password (Anti-Injection)
PREPARE `change_password` FROM
'UPDATE users SET password = ? WHERE username = ?;';
SET @username = '';
SET @password = '';
EXECUTE `change_password` USING @password, @username;

-- De-active product
UPDATE products SET is_active = FALSE
WHERE name = '';

-- De-active category
UPDATE categories SET is_active = FALSE
WHERE name = '';

-- Update inventory
UPDATE properties SET count = 0
WHERE product_id = 0 AND property_name = '' AND property_value = '';

-- Update profile
UPDATE profiles SET first_name = ''
WHERE user_id = (
    SELECT id FROM users
    WHERE username = ''
);

-- Mark order as done
UPDATE orders SET is_done = TRUE
WHERE user_id = (
    SELECT id FROM users
    WHERE username = ''
);

-- >> DELETE Statements

-- Delete a user
DELETE FROM users WHERE username = '';

-- Delete a product
DELETE FROM products WHERE name = '';
