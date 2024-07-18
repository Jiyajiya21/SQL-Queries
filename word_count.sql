
-- Find the number of words in each business name.
-- Avoid counting special symbols as words (e.g. &). Output the business name and its count of words.

with cte as(
SELECT business_name, regexp_split_to_table
(replace(business_name, '&', ''), '\s+') as count
FROM sf_restaurant_health_violations)

select business_name, count(count)
from cte 
group by 1;