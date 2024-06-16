# Online_Retailer-Database
Objective
The Online Retailer Database project aims to evaluate the ability to work with transactional data, aggregate functions, and subqueries. By designing a comprehensive database schema and writing SQL queries to perform various operations on the data, this project assesses proficiency in database management and querying.

Database Schema Design
The database schema includes tables for customers, orders, products, and order_items:

customers: Contains information about customers, including customer_id, first_name, last_name, and email.
orders: Stores details of orders placed, such as order_id, customer_id, and order_date.
products: Holds information about products available for purchase, with fields like product_id, product_name, and price.
order_items: Records the items included in each order, including order_item_id, order_id, product_id, quantity, and price.
SQL Queries
The following SQL queries demonstrate the functionality of the Online Retailer Database:

Total Number of Orders per Customer:

SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
Products Never Ordered:

sql
Copy code
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;
Customer Who Spent the Most in Last Month:

sql
Copy code
SELECT c.customer_id, c.first_name, c.last_name, SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;
Conclusion
The Online Retailer Database project demonstrates proficiency in database design and SQL querying techniques. By implementing the specified requirements, it provides a foundation for managing transactional data efficiently in an online retail environment.




