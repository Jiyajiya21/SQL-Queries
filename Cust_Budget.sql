-- Find how many projects falls under Customer Budget.

use new_db;

create table products1
(
product_id varchar(20) ,
cost int
);
insert into products1 values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);

select * from products1;
select * from customer_budget;

with cte as (select *
, sum(cost) over(order by cost) as r_cost
from products1) 
select customer_id
, budget
, count(product_id) as no_of_products
, group_concat(Product_id)
from  customer_budget 
left join cte on r_cost < budget
group by 1, 2








