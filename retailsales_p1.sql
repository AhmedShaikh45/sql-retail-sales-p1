-- Create database
CREATE DATABASE sql_project_p2;

-- Drop table if it already exists
DROP TABLE IF EXISTS retail_sales;

-- Create table
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sales_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);


SELECT * FROM retail_sales 
LIMIT 10;


SELECT COUNT(*) FROM retail_sales


--

SELECT * FROM retail_sales
WHERE transaction_id IS NULL

---

SELECT * FROM retail_sales
WHERE sales_date IS NULL
--
SELECT * FROM retail_sales
WHERE 
transaction_id IS NULL
OR
sales_date IS NULL
OR 
sale_time IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
cogs IS NULL
OR 
total_sale IS NULL
OR 
price_per_unit IS NULL

---

DELETE FROM retail_sales
WHERE 
transaction_id IS NULL
OR sales_date IS NULL
OR sale_time IS NULL
OR gender IS NULL
OR category IS NULL
OR quantity IS NULL
OR cogs IS NULL
OR total_sale IS NULL
OR price_per_unit IS NULL;

---
SELECT * FROM retail_sales LIMIT 1;

-- DATA EXPLORATION

-- NOW HOM MANY SALES WE HAVE
SELECT COUNT(*) AS total_sales FROM retail_sales
-- HOW MANY UNIQUE CUSTOMERS
SELECT COUNT(DISTINCT customer_id) AS total_sales FROM retail_sales
-- HOW MANY UNIQUE CATEGORY
SELECT DISTINCT category AS total_sales FROM retail_sales
--DATA ANALYST & BUSINESS KEY PROBLEMS ANSWERS

--Q1.SALES ON 2022-11-05
SELECT *
FROM retail_sales
WHERE sales_Date = '2022-11-05'

--Q2.ALL TRANSACTION FOR CATEGORY = 'CLOTHING' AND 
--QUANTITY SOLD IS MORE THAN 10 IN NOVEMBER

SELECT 
     category,
     SUM(quantity)
FROM retail_sales
WHERE category = 'Clothing'
GROUP BY 1 

--
SELECT 
     *
FROM retail_sales
WHERE category = 'Clothing'
     AND
	 TO_CHAR(sales_date,'YYYY-MM') = '2022-11'
GROUP BY 1 
-- FINAL ANSWERS
SELECT 
     *
FROM retail_sales
WHERE category = 'Clothing'
     AND
	 TO_CHAR(sales_date,'YYYY-MM') = '2022-11'
	 AND
	 quantity >= 4


--Q3.CALCULATE THE TOTAL SALES FOR EACH CATEGORY
SELECT  
     category,
     SUM(total_sale) AS net_sale,
	 COUNT(*)  AS total_orders
FROM retail_sales
GROUP BY 1

--Q4.AVERAGE AGE OF CUSTOMERS WHO BOUGHT BEAUTY CATEGORY

SELECT 
    ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty'

--Q5.FIND ALL TRANSACTION THAT HAS TOTAL SALES GREATER THAN 100 
SELECT * FROM retail_sales
WHERE total_sale > 1000

--Q6.TOTAL NUMBER OF TRANSACTIONS BY EACH GENDER IN EACH CATEGORY

SELECT 
     category,
	 gender,
	 COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category,gender
ORDER BY 1

--Q7.AVG SALES FOR EACH MONTH AND FIND OUT BEST SELLING MONTH
SELECT * FROM
(
 SELECT 
       EXTRACT(YEAR FROM sales_date) AS  year,
	   EXTRACT(MONTH FROM sales_date) AS month,
	   AVG(total_sale) AS avg_sale,
	   RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sales_date) ORDER BY AVG(total_sale) DESC)
 FROM retail_sales
 GROUP BY 1,2
 ORDER BY 1,3 DESC
) AS t1
WHERE RANK = 1
--
--Q8. TOP 5 CUSTOMERS BASED ON HIGHEST TOTAL SALES

SELECT 
       customer_id,
	   SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
--
--Q9.NUMBER OF CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY


SELECT 
       category,
       COUNT(DISTINCT customer_id) AS unique_cust,
	   SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
--
--Q.10WRITE A QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS (EXAMPLE MORNING <= 12 AFTERNOON BETWEEEN 12 & 17.EVENING > 17)
WITH hourly_sales AS (
    SELECT *,
           CASE
               WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
               WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM retail_sales
)
SELECT 
       shift,
       COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift
ORDER BY total_orders DESC;

--END OF PROJECT




































	