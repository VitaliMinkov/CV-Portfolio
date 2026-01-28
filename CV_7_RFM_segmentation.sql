-- 7) RFM customer segmentation
-- For each customer, calculate:
-- days since the last order,
-- number of orders,
-- total sales.
-- Assign each customer to a segment (loyal/active/stable/at_risk)
-- based on RFM scores from 1 to 5.

with customer_kpi_cte as
(select customer_name,
       max(order_date) as last_order_date,
       (current_date-max(order_date)) as recency_days,
       count(order_id) as frequency,
       sum(sales) as monetary
from orders
group by customer_name),
scores_cte as
(select *,
        ntile(5) over (order by recency_days DESC) as r_score,
        ntile(5) over (order by frequency ASC) as f_score,
        ntile(5) over (order by monetary Asc) as m_score
 from customer_kpi_cte)
    select customer_name,
           recency_days,
           frequency,
           monetary,
           r_score,
           f_score,
           m_score,
           case
               WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'loyal'
               WHEN r_score >= 3 AND f_score >= 3 and m_score >= 3  THEN 'active'
               WHEN r_score >= 2 AND f_score >= 2 and m_score >= 2 THEN 'stable'
               ELSE 'at risk'
               END as rfm_segment
    from scores_Cte
    order by r_score, f_score, m_score ASC