-- Finding the total hrs spend by each user each day 

use new_db;

CREATE TABLE swipe (
    employee_id INT,
    activity_type VARCHAR(10),
    activity_time datetime
);

-- Insert sample data
INSERT INTO swipe (employee_id, activity_type, activity_time) VALUES
(1, 'login', '2024-07-23 08:00:00'),
(1, 'logout', '2024-07-23 12:00:00'),
(1, 'login', '2024-07-23 13:00:00'),
(1, 'logout', '2024-07-23 17:00:00'),
(2, 'login', '2024-07-23 09:00:00'),
(2, 'logout', '2024-07-23 11:00:00'),
(2, 'login', '2024-07-23 12:00:00'),
(2, 'logout', '2024-07-23 15:00:00'),
(1, 'login', '2024-07-24 08:30:00'),
(1, 'logout', '2024-07-24 12:30:00'),
(2, 'login', '2024-07-24 09:30:00'),
(2, 'logout', '2024-07-24 10:30:00');

select * from swipe;

with cte as (select * 
, DATE(activity_time) AS activity_date
, row_number() over (partition by employee_id, DATE(activity_time) order by activity_time, employee_id)as rn
, row_number() over (partition by employee_id, DATE(activity_time) order by activity_time desc, employee_id )as rn1
from swipe
), cte2 as (select * 
 , case when activity_type = "login" then activity_time end as login_time
 , case when activity_type = "logout" then activity_time end as logout_time
from cte 
having rn = 1 or  rn1 = 1
order by employee_id, activity_time)
, cte3 as (select 
employee_id, activity_date, min(login_time) as login_time, min(logout_time) as logout_time
from cte2 
group by 1, 2)
select * from cte3 
select employee_id, activity_date
, TIMESTAMPDIFF(hour,login_time, logout_time)  
from cte3
;
















