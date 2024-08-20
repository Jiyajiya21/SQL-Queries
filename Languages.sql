-- Find company who have atleast 2 users who speaks both the languages English and German

use new_db;

create table company_users (
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German'),(1,2,'English'),(1,3,'German'),(1,3,'English'),(1,4,'English'),(2,5,'English'),(2,5,'German'),(2,5,'Spanish')
,(2,6,'German'),(2,6,'Spanish'),(2,7,'English');
select * from company_users;

with cte as (select * 
, row_number() over (partition by company_id, user_id) as rn
from company_users
where language in ( 'English' , 'German'))
select company_id, count(user_id)
from cte 
where rn = 2 
group by 1
having count(user_id) = 2;














