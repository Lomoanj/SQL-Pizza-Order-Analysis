create database pizzahut;
create table orders (order_id int not null, order_date date not null, order_time time not null, primary key(order_id));
create table order_details (order_details_id int not null, order_id int not null, pizza_id text not null, quantity int not null, primary key (order_details_id));

select * from order_details;
select * from orders;
select * from pizza_types;
select * from pizzas;

# 1. Total number of orders placed
select count(order_id) as total_orders from orders;

# 2. Total Sales Amount
select round(sum(a.quantity*b.price),2) as Total_Sales from order_details as a join pizzas as b on a.pizza_id=b.pizza_id;

# 3. Highest Price Pizza
select a.name, b.price from pizza_types as a join pizzas as b on a.pizza_type_id=b.pizza_type_id order by 2 desc limit 1;

# 4. Most pizza's size ordered
select b.size, count(a.order_details_id) as order_count from order_details as a join pizzas as b on a.pizza_id=b.pizza_id group by 1 order by 2 desc;

# 5. Top 5 most ordered pizza types along with their quantity
select a.name, sum(c.quantity) quantity from pizza_types as a join pizzas as b on a.pizza_type_id=b.pizza_type_id join order_details as c on c.pizza_id=b.pizza_id group by 1 order by 2 desc limit 5;

# 6. Total quantity of each pizza category ordered
select a.category, sum(c.quantity) quantity from pizza_types a join pizzas b on a.pizza_type_id=b.pizza_type_id join order_details c on c.pizza_id=b.pizza_id group by 1 order by 2 desc;

# 7. Determine the distribution or orders by hour of the day
select hour(order_time) hour, count(order_id) order_count from orders group by 1 order by 1;

# 8. Category-wise distribution of pizzas
select category, count(pizza_type_id) count from pizza_types group by 1 order by 2 desc;

# 9. Group the orders by date and calc the avg number of pizzas ordered per day
select round(avg(quantity)) avg_pizzas_per_day from (
select a.order_date, sum(b.quantity) as quantity from orders a join order_details b on a.order_id=b.order_id group by 1)abc;

# 10. Top 3 most ordered pizza based on revenue
select a.name, sum(b.quantity*c.price) revenue from pizza_types a join pizzas c on a.pizza_type_id=c.pizza_type_id join order_details b on b.pizza_id=c.pizza_id group by 1 order by 2 desc limit 3;

# 11. Percentage contribution of each pizza type to total revenue
select a.category, concat(round((sum(b.quantity*c.price)/(select round(sum(a.quantity*b.price),2) as Total_Sales from order_details as a join pizzas as b on a.pizza_id=b.pizza_id))*100,2)," %") Revenue_Contribution
 from pizza_types a join pizzas c on a.pizza_type_id=c.pizza_type_id join order_details b on b.pizza_id=c.pizza_id group by 1;

# 12. Cumulative revenue generated over time
select order_date, sum(revenue) over(order by order_date) as cum_revenue from
(select a.order_date, sum(b.quantity*c.price) revenue from order_details b join pizzas c on b.pizza_id=c.pizza_id join orders a on a.order_id=b.order_id group by 1)abc;

# 13. Top 3 most ordered pizza types based on revenue for each pizza category
select name, revenue from (
select category,name, revenue, rank() over(partition by category order by revenue desc) as rn from(
select a.category, a.name, sum(b.quantity*c.price) revenue from pizza_types a join pizzas c on a.pizza_type_id=c.pizza_type_id join order_details b
on b.pizza_id=c.pizza_id group by 1,2)abc)abc where rn <=3;
