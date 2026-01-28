-- 3) Top-3 products by profit margin in each region

with margin_cte as
(select region,
        product_id,
        product_name,
        sum(profit) as profit,
        sum(sales) as sales,
        round((sum(profit)/nullif(SUM(sales),0)),5) as margin
        from orders
        group by region, product_id,product_name)
select region,
       product_id,
       product_name,
       margin,
       profit,
       sales from
     (select region,
             product_id,
             product_name,
             profit,
             sales,
             margin,
             dense_rank() over (partition by region order by margin DESC, profit desc, sales desc) as rnk
    from margin_cte) as sub
where rnk<=3;
