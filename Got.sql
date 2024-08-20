-- for each region find house which has won maximum no of battles. Display region, house and no of wins

-- Create the 'king' table
use new_db;

CREATE TABLE king (
    k_no INT PRIMARY KEY,
    king VARCHAR(50),
    house VARCHAR(50)
);

-- Insert data into the 'king' table
delete from king where k_no = Null;
INSERT INTO king (k_no, king, house) VALUES
(1, 'Robb Stark', 'House Stark'),
(2, 'Joffrey Baratheon', 'House Lannister'),
(3, 'Stannis Baratheon', 'House Baratheon'),
(4, 'Balon Greyjoy', 'House Greyjoy'),
(5, 'Mace Tyrell', 'House Tyrell'),
(6, 'Doran Martell', 'House Martell');

-- Create the 'battle' table
CREATE TABLE battle (
    battle_number INT PRIMARY KEY,
    name VARCHAR(100),
    attacker_king INT,
    defender_king INT,
    attacker_outcome INT,
    region VARCHAR(50),
    FOREIGN KEY (attacker_king) REFERENCES king(k_no),
    FOREIGN KEY (defender_king) REFERENCES king(k_no)
);

-- Insert data into the 'battle' table
INSERT INTO battle (
battle_number, name, attacker_king, defender_king, attacker_outcome, region) VALUES(1, 'Battle of Oxcross', 1, 2, 1, 'The North'),
(2, 'Battle of Blackwater', 3, 4, 0, 'The North'),
(3, 'Battle of the Fords', 1, 5, 1, 'The Reach'),
(4, 'Battle of the Green Fork', 2, 6, 0, 'The Reach'),
(5, 'Battle of the Ruby Ford', 1, 3, 1, 'The Riverlands'),
(6, 'Battle of the Golden Tooth', 2, 1, 0, 'The North'),
(7, 'Battle of Riverrun', 3, 4, 1, 'The Riverlands'),
(8, 'Battle of Riverrun', 1, 3, 0, 'The Riverlands');

-- QUES 1> For each region find house which has won maximum no of battles. display region, house and no of wins
select * from battle;
select * from king;

with cte as (select * 
, case when attacker_outcome = 1 then attacker_king else defender_king end as Winner
from battle )
, cte2 as (
select b.region, k.house
, count(b.winner) as no_of_wins
, rank() over(partition by region order by count(b.winner) desc) as rn 
from cte b left join king k on b.winner = k.k_no
group by 1,2)

select *
from cte2 where rn = 1;














