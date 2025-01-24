describe coffee;

select round(SUM(unit_price * transaction_qty)) as total_sales
from coffee
where
month(transaction_date) = 5;

SELECT 
MONTH (transaction_date) AS month,
round(SUM(unit_price * transaction_qty)) as total_sales,
(sum(unit_price *transaction_qty)-lag(sum(unit_price * transaction_qty),1)
over (order by month(transaction_date)))/lag(sum(unit_price *transaction_qty),1)
over (order by month(transaction_date))*100 as mom_increase_percantage

from
coffee
where
month(transaction_date) in (4,5)
group by 
month(transaction_date)
order by
month (transaction_date);


select count(transaction_id) as total_orders
from coffee
where
month(transaction_date)=3; -- March

select Sum(transaction_qty) as total_quantity_sold
from coffee
where
month(transaction_date)=3;

-- total order kpi mom difference and mom growth
SELECT 
MONTH (transaction_date) AS month,
round(count(transaction_id)) as total_order,
(count(transaction_id)-lag(count(transaction_id),1)
over (order by month(transaction_date)))/lag(count(transaction_id),1)
over (order by month(transaction_date))*100 as mom_increase_percantage

from
coffee
where
month(transaction_date) in (4,5)
group by 
month(transaction_date)
order by
month (transaction_date);

-- mom increasee in order
SELECT 
MONTH (transaction_date) AS month,
round(sum(transaction_qty)) as total_quantity_sold,
(sum(transaction_qty)-lag(sum(transaction_qty),1)
over (order by month(transaction_date)))/lag(count(transaction_qty),1)
over (order by month(transaction_date))*100 as mom_increase_percantage

from
coffee
where
month(transaction_date) in (4,5)
group by 
month(transaction_date)
order by
month (transaction_date);

-- weakend  sat /sun
-- weekdays - monday - friday

select
case when dayofweek(transaction_date) in (1,7) then 'Weekends'
else 'weekdays'
end as Day_type,
CONCAT(round(sum(unit_price *transaction_qty)/1000,1),'k') as total_sales
from 
coffee
where month(transaction_date) =5
group by
case when dayofweek(transaction_date) in (1,7) then 'Weekends'
else 'Weekdays'
End
;

select
store_location,
concat(round(sum(unit_price * transaction_qty)/1000,1),'k') as total_sales
from
coffee
where
month(transaction_date) =5
group by store_location
order BY SUM(unit_price * transaction_qty) DESC;

SELECT 
concat(round(avg(total_sales)/1000,1),'k') as avg_sales
from
(
select concat(round(sum(transaction_qty*unit_price)/1000,1),'k')as total_sales
from coffee
where month(transaction_date) = 5
group by transaction_date
) as internal_query;

select
day(transaction_date) as day_of_month,
concat(round(sum(unit_price * transaction_qty)/1000,1),'k') as total_sales
from
coffee
where month(transaction_date) = 5
group by (transaction_date)
order by (transaction_date);

select
day_of_month,
case
  when total_sales > avg_sales then 'Above Average'
  when total_sales < avg_sales then 'Below Average'
  else 'Average'
  end as sales_status,
  total_sales
  from (
  select
  day(transaction_date)as day_of_month,
   concat(round(
   sum(unit_price*transaction_qty)/1000,1),'k') as total_sales,
  avg(sum(unit_price*transaction_qty)) over()as avg_sales
  from
  coffee
  where
  month(transaction_date)=5 -- filter for may
  group by 
  day(transaction_date)
  )
  as sales_date
  order by
  day_of_month;
  
  select
  product_category,
  concat(round(sum(unit_price * transaction_qty)/1000,1),'k') as total_sales,
  sum(transaction_qty) as total_qty_sold,
  count(*)
  from 
  coffee
  where month(transaction_date) = 5 and product_category = 'coffee'
  group by product_category
  order by sum(unit_price * transaction_qty) desc
  limit 10;
  
select
hour(transaction_time),
sum(unit_price * transaction_qty) as total_sales,
from
coffee
where month (transaction_date) = 5
group by hour(transaction_time)
order by hour(transaction_time)
  
  
select
case
when dayofweek(transaction_date) = 2 then 'Monday'
when dayofweek(transaction_date) = 3 then 'Tuesday'
when dayofweek(transaction_date) = 4 then 'Wednesday'
when dayofweek(transaction_date) = 5 then 'Thursday'
when dayofweek(transaction_date) = 6 then 'Friday'
when dayofweek(transaction_date) = 7 then 'Saturday'

Else 'Sunday'
End As Day_of_Week,
Round(sum(unit_price * transaction_qty)) as total_sales
from
coffee
where
month(transaction_date)=5 
group by
case
when dayofweek(transaction_date) = 2 then 'Monday'
when dayofweek(transaction_date) = 3 then 'Tuesday'
when dayofweek(transaction_date) = 4 then 'Wednesday'
when dayofweek(transaction_date) = 5 then 'Thursday'
when dayofweek(transaction_date) = 6 then 'Friday'
when dayofweek(transaction_date) = 7 then 'Saturday'
else 'Sunday'
End as Day_of_Week,
round(sum(unit_price * transaction_qty)) as total_sales
from
coffee
where
month(transaction_date) = 5 

group by
case
when dayofweek(transaction_date) =2 then 'Monday'
when dayofweek(transaction_date) =3 then 'Tuesday'
when dayofweek(transaction_date) =4 then 'Wednesday'
when dayofweek(transaction_date) =5 then 'Thursday'
when dayofweek(transaction_date) =6 then 'Friday'
when dayofweek(transaction_date) =7 then 'Saturday'
else 'Sunday'
End;




