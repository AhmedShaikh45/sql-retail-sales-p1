# SQL Retail Sales Analysis

## 📌 Project Overview

This project focuses on analyzing retail sales data using PostgreSQL to extract meaningful business insights. It covers data cleaning, transformation, and analysis using core SQL concepts such as CTEs, aggregations, CASE statements, and time-based analysis.

## 🗂 Dataset Description

The dataset contains transactional retail sales data with the following attributes:

* Transaction ID
* Sales date & time
* Customer details (ID, gender, age)
* Product category
* Quantity sold
* Pricing, COGS, and total sales value

## 🛠 Tools & Technologies

* PostgreSQL
* SQL (CTEs, JOINs, GROUP BY, CASE, DATE/TIME functions)
* pgAdmin

## 🔍 Key Analysis Performed

* Data validation and NULL value handling
* Sales distribution by category and gender
* Revenue analysis by time (hourly shifts: Morning/Afternoon/Evening)
* Order volume trends
* Business-friendly aggregations and metrics

## 📊 Sample Insights

* Identified peak sales shifts using time-based segmentation
* Analyzed customer purchasing patterns
* Evaluated revenue contribution by category

## 🎯 Learning Outcomes

* Improved SQL querying and debugging skills
* Hands-on experience with real-world retail data
* Practical understanding of business-focused data analysis

## 📁 How to Use

1. Create the database and table using the provided SQL scripts
2. Import the dataset (CSV)
3. Execute analysis queries step-by-step

---

## ❓ Business Questions & SQL Queries

Below are **business-oriented questions** with their corresponding **SQL solutions**, showcasing practical retail analytics skills.

---

### 🔹 Q1. What were the sales transactions on **2022-11-05**?

```sql
SELECT *
FROM retail_sales
WHERE sales_date = '2022-11-05';
```

---

### 🔹 Q2. Retrieve all transactions for **Clothing category** with quantity sold ≥ 4 in **November 2022**

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sales_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;
```

---

### 🔹 Q3. Calculate **total sales and total orders** for each product category

```sql
SELECT  
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

---

### 🔹 Q4. Find the **average age** of customers who purchased products from the **Beauty** category

```sql
SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

---

### 🔹 Q5. List all transactions where **total sales exceeded 1000**

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

---

### 🔹 Q6. Determine the **total number of transactions by gender in each category**

```sql
SELECT 
    category,
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

---

### 🔹 Q7. Find the **best-selling month (by average sales) for each year**

```sql
SELECT *
FROM (
    SELECT 
        EXTRACT(YEAR FROM sales_date) AS year,
        EXTRACT(MONTH FROM sales_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sales_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY 1, 2
) t
WHERE rank = 1;
```

---

### 🔹 Q8. Identify the **top 5 customers** based on highest total sales

```sql
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

### 🔹 Q9. Count the **number of unique customers per category** and their total sales

```sql
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY unique_customers DESC;
```

---

### 🔹 Q10. Create **time-based shifts** and calculate the number of orders per shift

*(Morning < 12, Afternoon 12–17, Evening > 17)*

```sql
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
```

---

⭐ This project demonstrates practical SQL skills suitable for **Data Analyst / Data Scientist roles**.oles.
