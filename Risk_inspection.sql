-- Find the number of inspections that resulted in each risk category per each inspection type in descending order.
select 
  inspection_type, 
  count(
    case when risk_category is Null then 1 end
  ) as No_risk, 
  count(
    case when risk_category = 'Moderate Risk' then 1 end
  ) as Moderate_Risk, 
  count(
    case when risk_category = 'High Risk' then 1 end
  ) as High_Risk, 
  count(
    case when risk_category = 'Low Risk' then 1 end
  ) as Low_Risk, 
  count(inspection_id) as Total_Inspections 
from 
  sf_restaurant_health_violations 
group by 
  1 
ORDER BY 
  total_inspections DESC;
