use New_db;

create table players
(player_id int,
group_id int);

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

select * from players;
select * from matches;

-- Ques 1) Find the Winners in each group. In case there is a tie return the Player with the smallest player_id.

with cte as (select p.group_id 
, p.player_id 
, m.first_score as score
from players p join matches m 
on p.player_id = m.first_player
union
select p.group_id 
, p.player_id
, m.second_score as score 
from players p join matches m 
on p.player_id = m.second_player
), cte2 as 
(select group_id, player_id, sum(score) as score
, row_number() over(partition by group_id order by sum(score) desc , player_id ) as dn 
from cte
group by 1, 2) 

select group_id, player_id, max(score)
from cte2 
where dn = 1
group by 1, 2


having dn = 1
order by group_id, sum desc





















