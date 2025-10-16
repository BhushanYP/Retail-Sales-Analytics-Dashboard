SELECT s.store_name,
       ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_revenue,
       COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN stores s ON o.store_id = s.store_id
GROUP BY s.store_name
ORDER BY total_revenue DESC;

SELECT c.category_name,
       p.product_name,
       SUM(oi.quantity) AS units_sold,
       ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name, p.product_name
ORDER BY total_revenue DESC
LIMIT 10;

SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS monthly_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       COUNT(DISTINCT o.order_id) AS total_orders,
       ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 10;

SELECT c.state,
       COUNT(DISTINCT c.customer_id) AS total_customers,
       ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.state
ORDER BY total_sales DESC;

SELECT s.store_id, p.product_name, st.quantity
FROM stocks st
JOIN products p ON st.product_id = p.product_id
WHERE st.quantity < 10
ORDER BY st.quantity ASC;

SELECT b.brand_name,
       ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN brands b ON p.brand_id = b.brand_id
GROUP BY b.brand_name
ORDER BY total_revenue DESC;

SELECT CONCAT(st.first_name, ' ', st.last_name) AS staff_name,
       ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS staff_revenue
FROM staffs st
JOIN orders o ON st.staff_id = o.staff_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY staff_name
ORDER BY staff_revenue DESC
LIMIT 5;

SELECT AVG(DATEDIFF(o.shipped_date, o.order_date)) AS avg_processing_days
FROM orders o
WHERE o.shipped_date IS NOT NULL;

SELECT CASE 
         WHEN oi.discount = 0 THEN 'No Discount'
         WHEN oi.discount BETWEEN 0.01 AND 0.1 THEN 'Low Discount'
         WHEN oi.discount BETWEEN 0.11 AND 0.3 THEN 'Medium Discount'
         ELSE 'High Discount'
       END AS discount_level,
       ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_revenue,
       COUNT(*) AS items_sold
FROM order_items oi
GROUP BY discount_level
ORDER BY total_revenue DESC;