-- Find the total amount based on rate per hour.

use new_db;

create table billings (
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from billings;
INSERT INTO billings (emp_name, bill_date, bill_rate) 
VALUES ('Sachin', '1990-01-01', 25),
('Sehwag', '1989-01-01', 15),
('Dhoni', '1989-01-01', 20),
('Sachin', '1991-02-05', 30);

create table HoursWorked 
(emp_name varchar(20),
work_date date,
bill_hrs int
);

insert into HoursWorked values
('Sachin', '1990-07-01', 3),
('Sachin', '1990-08-01', 5),
('Sehwag', '1990-07-01', 2),
('Sachin', '1991-07-01', 4);

select * from billings
select * from HoursWorked;

with cte as
	(select *
	, lead(DATE_ADD(bill_date, INTERVAL -1 DAY), 1, '9999-12-31') over (partition by emp_name) as till
	from billings)

select b.emp_name, sum( b.bill_rate * h.bill_hrs) as Total_Charges
from cte b  join HoursWorked h 
on b.emp_name = h.emp_name and h.work_date between b.bill_date and b.till
group by 1;

















