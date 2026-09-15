SELECT
    COUNT(DISTINCT user_id) AS users,
    COUNT(DISTINCT order_id) AS orders,
    SUM(amount) AS revenue,
    ROUND(SUM(amount) / NULLIF(COUNT(DISTINCT order_id), 0), 2) AS average_order_value
FROM orders
WHERE status = 'completed';
