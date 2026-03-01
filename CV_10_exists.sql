-- 10) Customers who purchased both Technology and Office Supplies
-- Find customers who bought products from both categories (Technology and Office Supplies) in the last 12 months.
-- For these customers, show the date of their first order within this period.

WITH last_year_CTE as (
    SELECT customer_id,customer_name, category, order_id, order_date
    FROM orders
    WHERE order_date >= (CURRENT_DATE - INTERVAL '365 days')
),
buyers_a_cte as (
         SELECT DISTINCT customer_id, customer_name
         FROM last_year_cte
         WHERE category = 'Technology'
),
buyers_b_cte as (
         SELECT DISTINCT customer_id
         FROM last_year_cte
         WHERE category = 'Office Supplies'
)
SELECT
    a.customer_name,
    MIN(f.order_date) as first_seen_date
FROM buyers_a_cte a
         JOIN last_year_cte f on f.customer_id = a.customer_id
WHERE EXISTS
    (SELECT 1 FROM buyers_b_cte b
    WHERE b.customer_id = a.customer_id)
GROUP BY a.customer_name
ORDER BY first_seen_date;
