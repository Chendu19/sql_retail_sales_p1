--sql retail sales analysis - p1
CREATE DATABASE sql_project_p2;



--create tabel
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
			    transactions_id	INT PRIMARY KEY,
				sale_date DATE,	
				sale_time TIME,
				customer_id	INT,
				gender VARCHAR(15),
				age	INT,
				category VARCHAR(25),	
				quantiy	INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
			);


SELECT * FROM reatil_sales
LIMIT 10

SELECT COUNT(*) FROM reatil_sales

--data cleaning
SELECT * FROM reatil_sales
WHERE transactions_id IS NULL

SELECT * FROM reatil_sales
WHERE sale_date IS NULL

SELECT * FROM reatil_sales
WHERE
transactions_id IS NULL
or
sale_date IS NULL
or
sale_time is null
or
customer_id IS NULL
OR
gender IS NULL
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

delete from reatil_sales
where
transactions_id IS NULL
or
sale_date IS NULL
or
sale_time is null
or
customer_id IS NULL
OR
gender IS NULL
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

--data exploration

--how many sales we have
SELECT COUNT(*) as total_sale from reatil_sales

--how many UNIQUE customers we have
SELECT COUNT(DISTINCT customer_id) as total_sale from reatil_sales

--Category we have
SELECT COUNT(DISTINCT category) as total_sale from reatil_sales

SELECT DISTINCT CATEGORY FROM reatil_sales

--DATA ANALYSIS & BUSINESS KEY PROBLEMS AND ANSWERS

--write an sql querry to retrive all columns for sales made on '2022-11-05'
SELECT * FROM reatil_sales
where sale_date = '2022-11-05';

--write an sql querry to retrive all transactions where the category is 'clothing' and  the quantity sold is more than 4 in the month of nov-2022
SELECT * FROM reatil_sales
WHERE category = 'Clothing' AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND quantiy >= 4

--write a sql query to calculate the total sales (total_sale) for each category
SELECT 
category,
sum(total_sale) as net_sale,
COUNT(*) as total_orders
from reatil_sales
GROUP BY 1;


--write a sql query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT round(avg(age), 2) as average_age
from reatil_sales
where category = 'Beauty';

--write a sql query to find all transactions where the total_sale is greater than 1000
SELECT * FROM reatil_sales
where total_sale > 1000;

--write an sql query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT
category, 
gender,
COUNT (*) as total_trans
from reatil_sales
GROUP BY category, gender
ORDER BY 1;

--write a sql query to calculate the average sale for each month. fine out best selling month in each year
SELECT
year,
month,
avg_sale
FROM
(
SELECT
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale) DESC) as rank
	from reatil_sales
	GROUP BY 1, 2
) as t1
WHERE rank = 1

--write a sql query to find the top 5 cutomers based on the highest total sales
SELECT
customer_id,
sum(total_sale) as total_sale
from reatil_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY
SELECT
category,
COUNT(DISTINCT(customer_id))
from reatil_sales
GROUP BY 1;

--write a sql query to create each shift and number of orders(example morning <=12, afternoon between 12 and 17, evening >17)
WITH hourly_sale
AS
(
SELECT *,
CASE
WHEN EXTRACT(HOUR FROM sale_time) <  12 THEN 'Morning'  
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon' 
ELSE 'evening'
END as shift
FROM reatil_sales
)
SELECT
shift,
COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift








