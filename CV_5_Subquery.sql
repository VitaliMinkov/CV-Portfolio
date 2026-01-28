-- 5) Shipping delays and average delivery time by ship mode
-- Calculate the average delivery time by region and ship_mode.
-- Include only valid dates and return only groups with at least 50 rows.

SELECT
    region,
    ship_mode,
    COUNT(*) asrows_cnt,
    ROUND(AVG(ship_days), 2) as avg_ship_days
FROM (
         SELECT
             region,
             ship_mode,
             ship_date - order_date as ship_days
         FROM orders
         WHERE ship_date IS NOT NULL
           AND order_date IS NOT NULL
           AND ship_date >= order_date
     ) as ship
GROUP BY region, ship_mode
HAVING COUNT(*) >= 50
ORDER BY avg_ship_days;
