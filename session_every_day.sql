-- Return the users that has sessions every day since thein first log in 

with cte as 
(select user_id
, min(cast(date_timestamp) as date) as First_login 
, date_diff(day, min(cast(date_timestamp) as date), getdate())+1 as total_No_of_days
from logins 
group by user_id
having count(distinct cast(date_timestamp)) =  date_diff(day, min(cast(date_timestamp) as date), getdate()))
select user_id 
from cte 
order by user_id; 