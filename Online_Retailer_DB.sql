CREATE DATABASE 1Alekhya;

USE 1Alekhya;

DROP DATABASE 1Alekhya;

DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS order_items;



SHOW DATABASES;
-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Create order_items table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (first_name, last_name, email) VALUES ('John', 'Doe', 'john.doe@example.com');
INSERT INTO customers (first_name, last_name, email) VALUES ('Jane', 'Smith', 'jane.smith@example.com');

INSERT INTO products (product_name, price) VALUES ('Product A', 10.00);
INSERT INTO products (product_name, price) VALUES ('Product B', 20.00);

INSERT INTO orders (customer_id, order_date) VALUES (1, '2023-06-01');
INSERT INTO orders (customer_id, order_date) VALUES (2, '2023-06-02');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (1, 1, 2, 10.00);
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (1, 2, 1, 20.00);
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (2, 1, 1, 10.00);

-- Query to find the total number of orders placed by each customer
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Query to list the products that have never been ordered
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;

-- Query to find the customer who has spent the most money in the last month
SELECT c.customer_id, c.first_name, c.last_name, SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;
