-- 2) Daily Active Users + New Users
-- For the last 90 days, calculate daily metrics:
-- DAU = number of unique customers who placed an order on that day
-- New customers = number of customers whose first-ever order occurred on that day

WITH period_cte as (
    SELECT
        (CURRENT_DATE - INTERVAL '90 days') as start_date,
        CURRENT_DATE AS end_date
),
order_days_cte as (
         SELECT DISTINCT
             order_date as day
         FROM orders
                  JOIN period_cte p
                       on order_date BETWEEN p.start_date AND p.end_date
         WHERE order_date IS NOT NULL
),
dau_cte as (
         SELECT
             order_date as day,
             COUNT(DISTINCT customer_id) as dau
         FROM orders
                  JOIN period_cte p
                       ON order_date BETWEEN p.start_date AND p.end_date
         WHERE order_date IS NOT NULL
         GROUP BY 1
),
first_order_cte as (
         SELECT
             customer_id,
             MIN(order_date) as first_day
         FROM orders
         WHERE order_date IS NOT NULL
         GROUP BY customer_id
),
new_customers as (
         SELECT
             first_day as day,
             count(*) as new_customers
         FROM first_order_cte
                  JOIN period_cte p
                       ON first_day BETWEEN p.start_date AND p.end_date
         GROUP BY first_day
)
SELECT
    od.day,
    COALESCE(d.dau, 0) as dau,
    COALESCE(n.new_customers, 0) as new_customers
FROM order_days_cte od
         LEFT JOIN dau_cte d
                   ON d.day = od.day
         LEFT JOIN new_customers n
                   ON n.day = od.day
ORDER BY od.day;
