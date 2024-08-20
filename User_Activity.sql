-- find the user's second most activity, in case there is only one return that

use new_db; 

create table UserActivity(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');

WITH CTE AS 
(SELECT *, ROW_NUMBER() OVER(PARTITION BY USERNAME ORDER BY STARTDATE) as ROW_NUMBER1
, count(activity) OVER(PARTITION BY USERNAME) cnt
FROM USERACTIVITY)

SELECT  username, activity, startdate, enddate 
FROM CTE 
where ROW_NUMBER1 = 2 or cnt < 2;

















