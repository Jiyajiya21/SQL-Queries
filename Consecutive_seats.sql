-- Find the Consecutive seats (3)
use new_db;

create table bms (seat_no int ,is_empty varchar(10));

insert into bms values
(1,'N'),(2,'Y'),(3,'N'),(4,'Y'),(5,'Y'),(6,'Y'),(7,'N'),(8,'Y'),(9,'Y'),(10,'Y'),(11,'Y'),(12,'N'),(13,'Y'),(14,'Y');

select * from bms;

with cte as (select *
, case 
		when lead(is_empty) over() = 'Y' and  lag(is_empty) over() = 'Y' and is_empty = 'Y' then 1 
		when lead(is_empty) over() = 'Y' and  lead(is_empty,2) over() = 'Y' and is_empty = 'Y' then 1
		when lag(is_empty) over() = 'Y' and  lag(is_empty,2) over() = 'Y' and is_empty = 'Y' then 1
        else 0 
end as flag
from bms)
select seat_no from cte where flag = 1;