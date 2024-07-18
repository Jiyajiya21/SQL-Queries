select * 
from icc_world_cup;
with cte as(
  select team_1 as Team_name 
    , case when Winner = team_1 then 1 else 0 end as winner 
  from icc_world_cup 
  UNION ALL 
  select team_2 as Team_name
   , case when Winner = team_2 then 1 else 0 end as winner 
  from icc_world_cup
) 
select 
  Team_name
  ,count(winner) as Total_no_of_Matches
  ,sum(winner) as Total_no_of_wins
  ,count(winner) - sum(winner) as Total_no_of_loses 
from cte 
group by 1;
