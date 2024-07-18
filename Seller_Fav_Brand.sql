-- Ques1 ) finding the sellers 2nd sold item is a favouriite brand of seller or not.

use Sales_db;

create table users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );
 
 -- Ques1) Find the second sold brand is Favourite of seller or not

 insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);
 
select * from users;
select * from items;
select * from orders;


with cte as 
(select u.user_id as seller_id, order_date, i.item_brand, u.favorite_brand
, rank() over (partition by o.seller_id order by o.order_date) as rk
from orders o
left join items i on o.item_id = i.item_id 
right join users u on u.user_id = o.seller_id)

, cte2 as (select seller_id
, case when item_brand =  favorite_brand then 'Yes' else 'No' end as second_fav_Brand
from cte 
where rk = 2) 

select u.user_id
, coalesce(cte2.second_fav_Brand, 'No')
from cte2 right join users u on u.user_id = cte2.seller_id;
















