-- Find the Maximum amount of each Sales_Person without using windows function, cte and sub Queries.

use new_db;

create table event_status(
event_time varchar(10),
status varchar(10)
);

insert into event_status 
values ('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');

select * from event_status;

with cte as (select * 
,sum(case when (status)  = 'on' and Prev  = "off" then 1 else 0 end) over (ORDER BY event_time  
rows between unbounded preceding and current row) as abc
from (
select *
, lag(status) over(order by event_time) as Prev
from event_status) a)

select 
min(event_time) as login, max(event_time) as logout, count(abc) - 1
from cte 
group by abc






















