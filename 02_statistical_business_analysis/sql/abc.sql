WITH product_revenue AS (
    SELECT product_id, SUM(amount) AS revenue
    FROM orders
    WHERE status = 'completed'
    GROUP BY product_id
),
abc AS (
    SELECT *,
        SUM(revenue) OVER (ORDER BY revenue DESC) AS cumulative_revenue,
        SUM(revenue) OVER () AS total_revenue
    FROM product_revenue
)
SELECT
    product_id,
    revenue,
    ROUND(cumulative_revenue * 100.0 / NULLIF(total_revenue, 0), 2) AS cumulative_percent,
    CASE
        WHEN cumulative_revenue / NULLIF(total_revenue, 0) <= 0.80 THEN 'A'
        WHEN cumulative_revenue / NULLIF(total_revenue, 0) <= 0.95 THEN 'B'
        ELSE 'C'
    END AS category
FROM abc
ORDER BY revenue DESC;
