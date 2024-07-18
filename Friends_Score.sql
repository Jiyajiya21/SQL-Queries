-- Ques 1 Find the Persons who have friends that scored greater than or equal to 100 combined.

use New_db;
Create table friend (pid int, fid int);
insert into friend (pid , fid ) values ('1','2');
insert into friend (pid , fid ) values ('1','3');
insert into friend (pid , fid ) values ('2','1');
insert into friend (pid , fid ) values ('2','3');
insert into friend (pid , fid ) values ('3','5');
insert into friend (pid , fid ) values ('4','2');
insert into friend (pid , fid ) values ('4','3');
insert into friend (pid , fid ) values ('4','5');

create table person (PersonID int,	Name varchar(50),	Score int);
insert into person(PersonID,Name ,Score) values('1','Alice','88');
insert into person(PersonID,Name ,Score) values('2','Bob','11');
insert into person(PersonID,Name ,Score) values('3','Devis','27');
insert into person(PersonID,Name ,Score) values('4','Tara','45');
insert into person(PersonID,Name ,Score) values('5','John','63');



with cte as 
(select distinct p.PersonID, p.name
, p.score, f.fid, p1.score as friend_score
from person p 
left join friend f on p.PersonID = f.pid
left join person p1 on p1.PersonID = f.fid) 

select PersonID
, name as Person_Name
, sum(friend_score) as total_fiend_score
, count(fid) as Total_Friend
from cte 
group by 1, 2
having sum(friend_score) >=100
