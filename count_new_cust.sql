with cte as (
select *
, min(order_date) over(partition by customer_id order by order_date) as First_order_date
from customer_orders
order by order_date
)
, cte2 as (
select *
, case when First_order_date = order_date then 1 else 2 end as flag
from cte
)
select order_date
, sum(case when flag = 1 then 1 end)as New_cust
, coalesce(sum(case when flag = 2 then 1 end), 0)as old_cust
from cte2
group by 1; 