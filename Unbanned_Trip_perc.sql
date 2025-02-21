use New_db;

Create table  Trips (id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50));

select * from Trips;
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');

select * from Users;
Create table Users (users_id int, banned varchar(50), role varchar(50));
insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');


with cancelled as (select t.request_at as request_at, count(u.users_id) as users
from Users u join Trips t on u.users_id = t.client_id
join Users u1 on u1.users_id = t.driver_id
where u.banned = 'No' and u1.banned = 'No' 
 and (t.status = 'cancelled_by_client' or  t.status = 'cancelled_by_driver')
group by 1)
, cte2 as (select t.request_at as request_at, count(u.users_id)as users1
from Users u join Trips t on u.users_id = t.client_id
join Users u1 on u1.users_id = t.driver_id
where u.banned = 'No' and u1.banned = 'No'
group by 1)

select cte2.request_at, round(coalesce(cancelled.users * 1.0 / cte2.users1 * 100, 0),2)
from cte2 left join cancelled on cte2.request_at = cancelled.request_at
-- group by 1












