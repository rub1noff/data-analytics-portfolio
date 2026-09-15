SELECT
    user_id,
    SUM(amount) AS ltv
FROM orders
WHERE status = 'completed'
GROUP BY user_id
ORDER BY ltv DESC;
