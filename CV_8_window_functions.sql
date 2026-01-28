-- 8) Pareto 80/20 analysis by customers
-- Validate the Pareto principle:
-- rank customers by total sales,
-- calculate cumulative revenue share,
-- and return customers who together account for the first 80% of total revenue.


with sales_cte as
(select customer_name,
       total_sales,
       sum(total_sales) over (order by total_sales desc) as cum_sales
from (
        select customer_name,
                 sum(sales) as total_sales
        from orders
        group by customer_name) sub1),
total_sales_cte as
(select sum(total_sales) as sales_all from sales_cte)
select customer_name,
       total_sales,
       cum_sales,
       cum_sales/(select sales_all from total_sales_cte) as cum_share
from sales_cte sc
group by 1,2,3
having cum_sales/(select sales_all from total_sales_cte) <=0.80
order by total_sales desc;

with sales_cte as
         (select customer_name,
                 total_sales,
                 sum(total_sales) over (order by total_sales desc) as cum_sales,
                 sum(total_sales) over () as sales_all
          from (
                   select customer_name,
                          sum(sales) as total_sales
                   from orders
                   group by customer_name) sub1)
select customer_name,
       total_sales,
       cum_sales,
       round(cum_sales/sales_all,2) as cum_share
from sales_cte sc
where cum_sales/sales_all <=0.80
order by total_sales desc;
