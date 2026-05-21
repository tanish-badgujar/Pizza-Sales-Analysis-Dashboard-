SELECT * FROM pizza_sales

--Q1 TOTAL REVENUE = the sum of the total price of all pizza orders.
SELECT SUM(total_price) AS Total_Revenue from pizza_sales

/*Q2 AVERAGE ORDER VALUE: the average amount spent per order. 
      , calculated by dividing the total revenue by the total number of orders.*/

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_Value from pizza_sales

--Q3 TOTAL PIZZAS SOLD; the sum of the quantities of all pizzas sold.
SELECT SUM(quantity) as Total_Pizzas_sold from pizza_sales

--Q4 TOTAL ORDERS; the total number of orders placed.
SELECT COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales

/*Q5 AVERAGE PIZZAS PER ORDER: the average number of pizzas sold 
   per order, calculated by dividing the number of pizzzas sold by the total number of orders.*/

   SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/
   CAST(COUNT(DISTINCT order_id ) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_par_order from pizza_sales

/* WE WOULD LIKE TO VISUAALIE VARIOUS ASPECTS OF OUR PIZZA SALES DAATA TO GAIN INSIGHTS AND UNDERSTAND KEY
  TRENDS. WE HAVE IDENTIFIED THE FOLLOWING REQUIREMENTS FOR CREATIG CHARTS:*/

-- 1 Daily Treand For Total Orders:
SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) as Total_orders
from pizza_sales
Group BY DATENAME(DW, order_date)

--2 Hourly Trend Total Orders:
SELECT DATEPART(HOUR, order_time) AS order_hours, COUNT(DISTINCT order_time) as total_orders
from pizza_sales
Group BY DATEPART(HOUR, order_time) 
ORDER BY DATEPART(HOUR, order_time)

--3 percentage of sales by pizza categort;
SELECT 
    pizza_category,
    SUM(total_price) AS Total_Sales,
    SUM(total_price) * 100 / 
    (SELECT SUM(total_price) 
     FROM pizza_sales 
     WHERE MONTH(order_date) = 1) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

--4 Percentage of Sales by Pizza Size:
SELECT pizza_size , CAST(sum(total_price) AS DECIMAL(10,2))AS Total_Sales, CAST(sum(total_price) * 100/
(SELECT sum(total_price) from pizza_sales WHERE DATEPART(quarter, order_date)=1) AS DECIMAL(10,2))AS PCT
from pizza_sales
WHERE DATEPART(quarter, order_date)=1
GROUP BY pizza_size
ORDER BY PCT DESC

--5 Total Pizza Sold BY Pizza Category:
SELECT pizza_category, sum(quantity) as Toatl_pizzas_sold
from pizza_sales
Group by pizza_category

--6 Top 5 Best Sellers by Total pizza Sold;
SELECT TOP 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
GROUP By pizza_name 
ORDER BY SUM(quantity) DESC

--7 Bottom 5 Worst Sellers  by Toatl PIzzas Sold;
SELECT top 5  pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
WHERE MONTH(order_date) =8
GROUP By pizza_name 
ORDER BY SUM(quantity) ASC
