-- Find the Recommended products (Recommendation System) 

use new_db; 

create table orders1
(
order_id int,
customer_id int,
product_id int
);

insert into orders1 VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

select * from orders1
select * from products

with cte as (select o.product_id as P1, o2.product_id as p2, count(1) as count
from orders1 o left join products p on o.product_id = p.id
inner join orders1 o2 on o.order_id = o2.order_id where o.product_id < o2.product_id
group by 1,2)

select concat(p.name, ' ', p1.name), cte.count 
from cte join products p on p.id = cte.p1
join products p1 on p1.id = cte.p2














