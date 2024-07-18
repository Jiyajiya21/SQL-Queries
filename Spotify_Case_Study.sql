-- Spotify Case Study SQL Queries

-- CREATE TABLE
CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);

-- INSERT VALUES IN TABLE
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

-- SELECTION OF TABLE
select * from activity ;

-- SQL QUUERIES

-- Ques1) Count of users who installed and get subscription on same day.

with cte as (select user_id, event_date, count(event_name) as Event_count
from activity
group by 1,2
having Event_count >= 2)

select a.event_date, count(distinct cte.user_id) as No_of_users
from cte right join activity a on cte.event_date = a.event_date
group by 1;

-- Ques2) Percertage of paid users in india, USA and and any other country should be others 

with cte as 
(select country
, round(count(user_id) * 1.0  / (select count(user_id) from activity where event_name = 'app-purchase') * 100.0, 2)as count
from activity
where event_name = 'app-purchase'
group by 1)
, cte2 as (select *
, case when country in ('India', 'USA') then country  
else 'others' end as region 
from cte) 
select cte2.region as country
, concat(sum(cte2.count),'%') as perc_users
from cte2 
group by 1;

-- Ques 3) How many users did App-Inpurchase on the very next day of Installed

with cte as 
(select a.user_id, a.event_date as app_purchase_date, b.app_installed_date
from activity a join 
		(select user_id, event_date as app_installed_date
		from activity where event_name = 'app-installed') b 
on a.user_id = b.user_id
where a.event_name = 'app-purchase' and datediff(event_date, app_installed_date)= 1)

select a.event_date
, count(distinct cte.user_id) as cnt_users
from cte right join activity a 
on cte.app_purchase_date = a.event_date
group by 1;
