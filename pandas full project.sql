select * from walmart;
select count(distinct(branch))
from walmart;

select max(quantity)from walmart;
--------------------------------------------------------------
-- bussiness problem
--Q1. find different payment method and number of transactions,number of qty.sold
select count(payment_method)
from walmart;

select payment_method,count(*) as number_of_payment,sum(quantity) as no_qty_Sold from walmart
group by payment_method;
--------------------------------------------------------------
--Q2.Identify the highest-rated category in each branch, displaying the branch, category AVG RATING

select *
from
(select 
    branch,
    category,
    avg(rating) as avg_rating,
    rank() over(partition by branch order by avg(rating) desc) as rank_
from walmart
group by branch, category
)
where rank_ = 1
;
--------------------------------------------------------------
--Q3. Identify the busisest day for each branch based on the number transaction

select *
from
( select branch,-- column 1
to_char(to_date(date,'dd/mm/yy'),'day') as Day_name ,-- column 2
count(*)as No_Transactions,
rank() over(partition by branch order by count(*) desc)
as rank_
from walmart

group by 1,2
)
where rank_ = 1
--------------------------------------------------------------
--Q4. Calculate the total quantity of items sold per payment method.list payment_method and total_qauntity.
select payment_method,count(*)as no_transactions,sum(quantity)as total_qauntity
from walmart
group by payment_method
order by total_qauntity desc
;
--------------------------------------------------------------
--Q5.
-- Determine the average,minimum,and maximum rating of products for each city.
-- List the city,average_rating,min_rating,and max_rating.
select city,category,
round(avg(rating)::numeric,2)as average_rating,
max(rating) as max_rating,
min(rating)as min_rating
from walmart
group by city,category;
--------------------------------------------------------------
--Q6.
-- Calculate the total profit for each category by considering total profit as 
-- (unit_price * quantity * profit_margin).list category and total_profit,orders from highest to lowest profit.
select * from walmart;

select category,round((total_quantity * profit_margin)::numeric,2) as total_profit,date,
to_char(to_date(date,'dd/mm/yy'),'day') as Day_name 
from walmart
group by category,total_quantity,profit_margin,date
order by total_profit desc
;
--------------------------------------------------------------(MONTH WISE)
select category,
to_char(to_date(date,'dd/mm/yy'),'month') as Month_name,
sum(round((total_quantity * profit_margin)::numeric,2)) as total_profit
from walmart
group by category,Month_name
order by Month_name,total_profit desc
;
--------------------------------------------------------------(YEAR WISE)
select 
    category,
    extract(year from to_date(date, 'DD/MM/YY')) as year,
    trim(to_char(to_date(date, 'DD/MM/YY'), 'Month')) as month_name,
    sum(round((total_quantity * profit_margin)::numeric, 2)) as total_profit
from walmart
group by category, year, month_name
order by year, month_name, total_profit desc;

--------------------------------------------------------------
--Q7.
--  Determine the most common payment method for each branch.
-- Display Branch and the preferrd_payment_method.

select branch,
payment_method as preferred_payment_method,
method_count as most_prefferd_payment_method
from(select 
branch, 
payment_method, 
count(*) as method_count,
rank() over(partition by branch order by count(*) desc) as rnk
from walmart
group by branch, payment_method
)sub
where rnk = 1;
--------------------------------------------------------------
select branch, most_prefferd_payment_method
from
(select branch,payment_method as most_prefferd_payment_method,count(payment_method) as count_,
rank()over(partition by branch order by count(*) desc ) as rnk
from walmart
group by branch,most_prefferd_payment_method)
sub where rnk = 1
;
----------------------------------------------------------
select branch, payment_method as preferred_payment_method
from (select branch,payment_method, 
count(*) as method_count,
rank() over(partition by branch order by count(*) desc) as rnk
from walmart
group by branch, payment_method
)sub
where rnk = 1;

----------------------------------------------------------(Each Branch payment_method(count))
select 
branch, 
payment_method, 
count(*) as method_count,
rank() over(partition by branch order by count(*) desc) as rnk
from walmart
group by branch, payment_method;

-------------------------------------------------------------------------------------------------
--Q8. 
-- Categorize sales into 3 groups MORNING,AFTERNOON,EVENING
-- Find out each of the shift and number of invoices.
select * from walmart;

select branch,case 
when extract(hour from(time::time))< 12 then 'Morning'
when extract(hour from(time::time)) between 12 and 17 then 'AfterNoon'
else 'Evening'
end as Day_Time,count(*) as total_sales
from walmart
group by branch,Day_Time
order by  branch,total_sales desc;


-------------------------------------------------------------------------------------------------
--Q9. 
-- Identify 5 Branch with highest decrease ratio in
-- revenue compare to last year(current year 2023 and last year 2022).
select * from walmart;

--rdr == ((last_rev - cr_rev) / lst_rev)*100

select branch, 
sum(total_quantity) as revenue
from walmart
group by 1;
---------2022Sales--------------------
with revenue_2022
as 
(select branch, 
sum(total_quantity) as revenue
from walmart
where 
extract(year from to_date(date,'dd/mm/yy')) = 2022
group by 1
)
,
revenue_2023
as 
(select branch, 
sum(total_quantity) as revenue
from walmart
where 
extract(year from to_date(date,'dd/mm/yy')) = 2023
group by 1)

select 
ls.branch,
ls.revenue as last_year_revenue,
cs.revenue as current_year_revenue,
round(((ls.revenue - cs.revenue)::numeric/ls.revenue::numeric) * 100,2) as rev_decs_ratio
from revenue_2022 as ls
join 
revenue_2023 as cs
on ls.branch = cs.branch

where 
ls.revenue >cs.revenue

order by 4 desc
limit 5




