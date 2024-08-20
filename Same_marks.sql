-- Find the students who have same marks in Physics and Chemistry

use new_db;

create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);

select *  from exams;

with cte as 
(select * 
, case when lead(marks) over (partition by student_id order by subject) = marks then 1 else 0 end as flag
from exams
where subject in ('Physics', 'Chemistry'))
select student_id from cte 
where flag = 1;