-- 9) Loss-making orders vs customer's average margin
-- List loss-making orders (profit < 0)
-- and show the customer's average margin across all of their orders.

SELECT
    o.order_id,
    o.customer_name,
    o.sales,
    o.profit,
    (
        SELECT
            SUM(o2.profit) / NULLIF(SUM(o2.sales), 0)
        FROM orders o2
        WHERE o2.customer_name = o.customer_name
    ) as customer_avg_margin
FROM orders o
WHERE o.profit < 0
ORDER BY o.profit ASC;




