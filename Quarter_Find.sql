-- Find the Quaters where store was under contruction 

use new_db;

CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),('S1', 'Q2', 300),('S1', 'Q4', 400),('S2', 'Q1', 500),('S2', 'Q3', 600),
('S2', 'Q4', 700),('S3', 'Q1', 800),('S3', 'Q2', 750),('S3', 'Q3', 900);
select * from STORES;

select store, concat ('Q', 10 - sum(substring(Quarter,-1,1)))as temp
from stores
group by 1;
















