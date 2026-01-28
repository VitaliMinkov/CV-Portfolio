-- 1. Calculate monthly metrics by region:
-- number of orders,
-- number of customers,
-- revenue,
-- profit and profit margin.
-- Additionally, calculate revenue change MoM (month-over-month)
-- and YoY (year-over-year, compared to the same month last year).
-- Protect against division by zero.


with monthly_CTE as
(select to_char((date_trunc('month', order_date)::date),'Month YYYY') as month_label,
       (date_trunc('month', order_date)::date) as month,
       region,
       count(order_id) as orders_cnt,
       count(customer_id) as customer_cnt,
       round(sum(sales),2) as sales,
       round(SUM(profit),2) as profit
       from orders
group by month, region
order by month)
select month,
       month_label,
       region,
       orders_cnt,
       customer_cnt,
       sales,
       profit,
       round(profit/(Nullif(sales,0)),2) as margin,
       sales-lag(sales) over (partition by region order by month) as sales_mom,
       sales-lag(sales,12) over (partition by region order by month) as sales_yoy
from monthly_CTE
order by month, region;






