with most_visited_floor1 as 
(select name, floor, count(floor)as most_visited
from entries
group by 1,2)

, max_most_visited_floor as 
(select *, dense_rank() over (partition by name order by most_visited desc) as rn
from most_visited_floor1)

, Total_Visits as 
(select name, count(name) as Total_Visits 
from entries 
group by 1)

select e.name
, mm.floor as Most_visited_floor
, tv.Total_Visits
, GROUP_CONCAT(distinct resources SEPARATOR ', ')
from entries e 
join Total_Visits tv on tv.name = e.name
join max_most_visited_floor mm on mm.name = e.name
where rn = 1
group by 1,2,3