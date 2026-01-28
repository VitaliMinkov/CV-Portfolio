-- 4) Measure the impact of discounts on profitability and return rate
-- Bucket orders by discount level (0%, 0–10%, 10–30%, 30%+)
-- and for each category calculate:
-- average sales/profit,
-- profit margin, and return rate.


with bucket_returns_cte as
(select o.*,
    case
        when discount is null then 'unknown'
        when discount = 0 then '0%'
        when discount > 0 and discount <= 0.1 then '0-10%'
        when discount > 0.1 and discount <= 0.3 then '10-30%'
        else '30+%'
    end as bucket,
    (r.order_id is not null) as is_returned
 from orders o
 left join returns r
 on o.order_id=r.order_id)
select category,
       bucket,
       round(avg(sales),3) as avg_sales,
       round(avg(profit),3) as avg_profit,
       round((sum(profit)/nullif(sum(sales),0)),3) as margin,
       round(avg(case when is_returned then 1 else 0 end),3) as return_rate
from bucket_returns_cte
group by category, bucket

