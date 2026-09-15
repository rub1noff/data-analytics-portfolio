WITH rfm AS (
    SELECT
        user_id,
        CURRENT_DATE - MAX(order_date)::date AS recency,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(amount) AS monetary
    FROM orders
    WHERE status = 'completed'
    GROUP BY user_id
)
SELECT *,
    NTILE(5) OVER (ORDER BY recency DESC) AS recency_score,
    NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
    NTILE(5) OVER (ORDER BY monetary) AS monetary_score
FROM rfm;
