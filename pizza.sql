use Pizza_Sales;

-- problem statement 1 Q1: The total number of order place

SELECT COUNT(*) as total_orders
FROM orders;

-- problem statement 2 Q2: The total revenue generated from pizza sales

SELECT SUM(p.price * od.quantity) as total_revenue
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id;

-- problem statement 3 Q3: The highest priced pizza.

SELECT *
FROM pizza
ORDER BY price DESC
LIMIT 1;

-- problem statement 4 Q4: The most common pizza size ordered.

SELECT size, COUNT(*) as count
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
GROUP BY size
ORDER BY count DESC
LIMIT 1;

-- problem statement 5 Q5: The top 5 most ordered pizza types along their quantities.

SELECT pt.name, COUNT(*) as count
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY count DESC
LIMIT 5;

-- problem statement 6 Q6: The quantity of each pizza categories ordered.

SELECT pt.category, SUM(od.quantity) as total_quantity
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- problem statement 7 Q7: The distribution of orders by hours of the day.

SELECT EXTRACT(HOUR FROM o.time) as hour, COUNT(*) as count
FROM orders o
GROUP BY hour
ORDER BY hour;

-- problem statement 8 Q8: The category-wise distribution of pizzas.

SELECT pt.category, COUNT(*) as count
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- problem statement 9 Q9: The average number of pizzas ordered per day.

SELECT AVG(total_pizzas) as average_daily_pizzas
FROM (
  SELECT DATE(o.date) as date, SUM(od.quantity) as total_pizzas
  FROM orders o
  JOIN order_details od ON o.order_id = od.order_id
  GROUP BY DATE(o.date)
) as daily_pizzas;

-- problem statement 10 Q10: Top 3 most ordered pizza type base on revenue.

SELECT pt.name, SUM(p.price * od.quantity) as revenue
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;

-- problem statement 11 Q11: The percentage contribution of each pizza type to revenue.

SELECT pt.name, SUM(p.price * od.quantity) as revenue,
       (SUM(p.price * od.quantity) / 
        (SELECT SUM(p.price * od.quantity) FROM order_details od
         JOIN pizza p ON od.pizza_id = p.pizza_id)) * 100 as percentage
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name;

-- problem statement 12 Q12: The cumulative revenue generated over time.

SELECT o.date, SUM(p.price * od.quantity) as cumulative_revenue
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN orders o ON od.order_id = o.order_id
GROUP BY o.date
ORDER BY o.date;

-- problem statement 13 Q13: The top 3 most ordered pizza type based on revenue for each pizza category.

SELECT pt.category, pt.name, SUM(p.price * od.quantity) as revenue
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category, pt.name
ORDER BY revenue DESC
LIMIT 3;