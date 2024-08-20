-- Find the Maximum amount of each Sales_Person without using windows function, cte and sub Queries.

use new_db;

CREATE TABLE int_orders(
 order_number int,
 order_date date ,
 cust_id int,
 salesperson_id int,
 amount float); 


INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) 
VALUES (30, CAST('1995-07-14' AS Date), 9, 1, 460), (10, CAST('1996-08-02' AS Date), 4, 2, 540), (40, CAST('1998-01-29' AS Date), 7, 2, 2400),
(50, CAST('1998-02-03' AS Date), 6, 7, 600), (60, CAST('1998-03-02' AS Date), 6, 7, 720),(70, CAST('1998-05-06' AS Date), 9, 7, 150)
, (20, CAST('1999-01-30' AS Date), 4, 8, 1800);

select * from int_orders;

select i1.salesperson_id
, max(i1.amount) as max
from int_orders i1 join int_orders i2 on i1.salesperson_id = i2.salesperson_id
group by 1













