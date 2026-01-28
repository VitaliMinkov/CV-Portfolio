-- 6) Return rate by manager and category
-- Show performance metrics by regional manager:
-- sales, profit, return_rate, and the share of sales from returned orders.
-- Exclude categories with fewer than 100 orders.

with managers_cte as
(select o.region,
       p.manager,
       o.category,
       o.order_id,
       sum(sales) as total_sales,
       sum(profit) as total_profit
from orders o
join people p on p.region=o.region
group by 1,2,3,4),
return_cte as
(select m.*,
    case when r.order_id is not null then 1 else 0 end as returned
from managers_cte m
    LEFT JOIN returns r ON r.order_id=m.order_id)
select region,
       manager,
       category,
       count(*) as orders_cnt,
       round(sum(total_sales),2) as sales,
       round(sum(total_profit),2) as profit,
       round(avg(returned),2) as return_rate,
       round(sum(case when returned=1 then total_sales else 0 end)/nullif(sum(total_sales),0),2) as return_sales_share
from return_cte
group by region, manager, category
having count(*)>100
order by return_rate DESC, profit ASC;

select region,count(*)
from people
group by region
having count(*)>1;


