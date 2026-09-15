WITH user_orders AS (
    SELECT user_id, COUNT(DISTINCT order_id) AS orders_count
    FROM orders
    GROUP BY user_id
),
stats AS (
    SELECT AVG(orders_count) AS avg_orders,
           STDDEV(orders_count) AS std_orders
    FROM user_orders
)
SELECT user_orders.user_id, user_orders.orders_count
FROM user_orders
CROSS JOIN stats
WHERE user_orders.orders_count > stats.avg_orders + 3 * stats.std_orders
ORDER BY user_orders.orders_count DESC;
