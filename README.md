# 🍕 Pizza Orders Analysis

This project analyzes pizza order data using SQL by joining four related datasets. It explores sales trends, customer behavior, and product performance to derive actionable insights for business growth and efficiency.

---

## 📌 Table of Contents

- [Project Objective](#project-objective)
- [Tools Used](#tools-used)
- [SQL Highlights & Sample Queries](#-sql-highlights--sample-queries)
- [📊 Insights](#-insights)
- [✅ Recommendations](#-recommendations)
- [Author](#-author)
- [Contact](#-contact)

---

## 🎯 Project Objective

The goal of this project is to explore pizza order data to uncover trends in customer preferences, product performance, and order patterns. These insights help in making informed business decisions.

---

## 🧰 Tools Used

- MySQL
- CSV files (joined using SQL)

---

## 🧮 SQL Highlights & Sample Queries

- 📌 **Top 3 most ordered pizza types based on revenue for each pizza category**  
```sql
select name, revenue from (
select category,name, revenue, rank() over(partition by category order by revenue desc) as rn from(
select a.category, a.name, sum(b.quantity*c.price) revenue from pizza_types a join pizzas c on a.pizza_type_id=c.pizza_type_id join order_details b
on b.pizza_id=c.pizza_id group by 1,2)abc)abc where rn <=3;
```
- 📌 **Percentage contribution of each pizza type to total revenue**
```sql
select a.category, concat(round((sum(b.quantity*c.price)/(select round(sum(a.quantity*b.price),2) as Total_Sales
from order_details as a join pizzas as b on a.pizza_id=b.pizza_id))*100,2)," %") Revenue_Contribution
from pizza_types a join pizzas c on a.pizza_type_id=c.pizza_type_id join order_details b on b.pizza_id=c.pizza_id group by 1;
```
- 📌 **Determine the distribution or orders by hour of the day**
```sql
select hour(order_time) hour, count(order_id) order_count from orders group by 1 order by 1;
```
[SQL Queries Link](https://github.com/Lomoanj/SQL-Pizza-Order-Analysis/blob/main/Pizza%20Queries.sql)  
[Dataset](https://github.com/Lomoanj/SQL-Pizza-Order-Analysis/tree/main/Dataset)  

---

## 📊 Insights

- 🕒 **Rounding peak order time**: Most orders occur between **1 PM to 6 PM**.
- 💰 **Top revenue generators**: A few premium pizza types account for a large portion of sales.
- 🍕 **Most popular size**: Medium-sized pizzas are the most frequently ordered.
- 📦 **Top categories**: Classic and Chicken categories drive the highest quantity and revenue.
- 📈 **Pizza ordering trend**: Weekends show spikes in order volume.
- 📊 **Cumulative revenue** steadily increases with consistent daily growth.

---

## ✅ Recommendations

- 📈 Promote **top 3 high-revenue pizza types** with combo offers.
- 🕒 Run **marketing campaigns around peak hours and weekends**.
- 🧀 Introduce new pizzas in the **best-selling categories (Classic, Chicken)**.
- 💸 Use **upselling strategies for larger sizes**, especially during evening hours.
- 🗓 Optimize **staffing and inventory for weekends** based on peak demand trends.

---

## ✨ Author

**Lomoanj P J** – Data Analyst  
Delivering data-driven business insights through SQL and visualization.

---

## 📬 Contact

- **LinkedIn**: [linkedin.com/in/lomoanj](https://www.linkedin.com/in/lomoanj/)  
- **Email**: [lomoanj@gmail.com](mailto:lomoanj@gmail.com)  
- **GitHub**: [github.com/Lomoanj](https://github.com/Lomoanj)
