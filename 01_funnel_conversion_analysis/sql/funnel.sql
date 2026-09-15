WITH funnel AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_name = 'visit' THEN user_id END) AS visits,
        COUNT(DISTINCT CASE WHEN event_name = 'product_view' THEN user_id END) AS product_views,
        COUNT(DISTINCT CASE WHEN event_name = 'add_to_cart' THEN user_id END) AS cart_users,
        COUNT(DISTINCT CASE WHEN event_name = 'purchase' THEN user_id END) AS purchases
    FROM events
)
SELECT
    visits,
    product_views,
    cart_users,
    purchases,
    ROUND(product_views * 100.0 / NULLIF(visits, 0), 2) AS visit_to_product,
    ROUND(cart_users * 100.0 / NULLIF(product_views, 0), 2) AS product_to_cart,
    ROUND(purchases * 100.0 / NULLIF(cart_users, 0), 2) AS cart_to_purchase,
    ROUND(purchases * 100.0 / NULLIF(visits, 0), 2) AS overall_conversion
FROM funnel;
