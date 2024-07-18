-- Cinema consecutive seat booking


with cte as (
select seat_id, free
, lag(free) over(order by seat_id) as Previous
, lead(free) over(order by seat_id) as Next1
from cinema)

select seat_id from cte
where (free = 1 and Previous = 1) or (free = 1 and Next1 = 1)
order by seat_id