--create table --
drop table if exists retail_sales;
create table retail_sales
     (
         transactions_id  int primary key ,	
		 sale_date date,
		 sale_time time,
		 customer_id int ,
		 gender	varchar(15),
		 age	int,
		 category varchar(35),
		 quantity int,
		 price_per_unit float,
		 cogs	float,
		 total_sale float

);
select * from retail_sales;

select 
count(*)
from  retail_sales

--  data cleaning--

select * from retail_sales
where transactions_id is null

select * from retail_sales
where sale_date is null

select * from retail_sales
where
    transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or 
	gender is null 
	or 
	category is null
	or 
	quantity is null
	or 
	cogs is null 
	or 
	total_sale is null;

----deleting null values rows

 delete from retail_sales 
 where
    transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or 
	gender is null 
	or 
	category is null
	or 
	quantity is null
	or 
	cogs is null 
	or 
	total_sale is null;

---data exploration 

-- how many sales we have 
select count(*)as total_sale from retail_sales

-- how many unique customers we have
select count(distinct customer_id) as total_sale from retail_sales

select distinct category as total_sale from retail_sales


--data analysis & business key problema and answer 

--Q1 - write a sql query to retrieve all columns from sales made on 2022-11-05
 select * 
 from retail_sales 
 where sale_date ='2022-11-05';

-- Q2- write a sql query to retrieve all transactions where the category is clothing and the quantity sold is more than 4 in the month of nov-2022

select 
 *      
from retail_sales
where category = 'Clothing'
   and 
   to_char(sale_date, 'YYYY-MM') = '2022-11'
   and quantity >= 04


-- Q3- write a sql query to calculate the total sales (total_sale) for each category

select
category,
sum(total_sale) as  net_sale,
count(*) as total_orders
from retail_sales
group by category;

--Q4 - write a sql query to find the average age of customers who purchased items from the 'beauty' category.

select
avg(age) as avg_age
 from Retail_sales
where category = 'Beauty'

--Q5- write a sql query to find all transactions where thr total_sale is greater than 1000.

select *  from retail_sales 
where total_sale>1000

--Q6 write a sql query to find the total number of transactions (transaction_id) made by each gender in each category 

select 
category ,
gender,
count(*) as total_trans
from retail_sales
group by 
category,
gender

--Q7 write a sql query to calculate the average sale for each month . find out best selling in each year
select 
      year,
	  month,
	  avg_sales
from 
(
select 
  extract(year from sale_date) as year,
     extract(month from sale_date) as month,
 
   avg(total_sale) as avg_sales,
   rank() over(partition by extract(year from sale_date)order by  avg(total_sale) desc ) as rank
   from retail_sales
   group by 1,2
   order by 1,3 desc
   ) as t1
   where rank = 1


--Q8 write a sql query to find the top 5 customers based on the heighest total sales

select 
     customer_id,
	 sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc	
limit 5

-- Q9- write a sql query to find the number of unique customers who purchased items from each category

select 
category,
 count(distinct customer_id) as unique_customer
from retail_sales
group by category 


--Q10 write a sql query to create shift and number of orders (example morning <=12 , afternoon betwwen 12&17.evening >17 )

with hourly_sale
as
(
select *,
 case
	 when extract (hour from sale_time) <12 then 'morning'
	 when extract (hour from sale_time) between 12  and 17 then 'afternoon' 
	 else 'evening'
	 end as shift
from retail_sales
)
select
    shift,
	count(*) as total_orders
 from hourly_sale
group by shift  



                                 ---end of project ---
