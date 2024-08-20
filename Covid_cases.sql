-- Find out the cities where the number of cases are continuosly increasing

use new_db;

create table covid(city varchar(50),days date,cases int);

insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);
insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);
insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);
insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);

select * from covid;

with cte as (select * 
, case when lead(cases) over(partition by city order by days) > cases then 1 else 0 end as flag
from covid) 

, cte2 as (select city, sum(flag) as sum, count(cases) - 1 as count
from cte
group by 1) 

select city 
from cte2
where sum = count;














