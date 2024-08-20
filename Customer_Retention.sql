-- Find the customer retention 

use new_db;

create table transactions(
order_id int,
cust_id int,
order_date date,
amount int);

insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;

with cte as (select *, month(order_date)
, lag(order_date) over(partition by cust_id order by order_date) as temp
from transactions)

,cte2 as (select *
, case when max(temp) over(partition by cust_id) is null then 'Churn' else 'Retention' end as result
from cte )


select month(order_date), count(distinct temp)
from cte2 
where result = 'Retention'
group by 1
order by month(order_date)




