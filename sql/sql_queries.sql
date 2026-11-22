-- Basic SQL Demo
-- Create a simple employees table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  delivery_id VARCHAR NOT NULL,
  restaurant_id VARCHAR NOT NULL,
  customer_id VARCHAR NOT NULL,
  order_value FLOAT,
  items_count INTEGER
);

-- Insert sample data
INSERT INTO "orders" (order_id, delivery_id, restaurant_id, customer_id, order_value, items_count) VALUES
  (1, 'A1','R1','C1',5,2),
  (2,'A2','R2','C2',4,1),
  (3,'A3','R4','C3',9,3),
  (4,'A4','R4','C4',7,1),
  (5,'A5','R1','C5',1,2),
  (6,'A6','R2','C6',6,1),
  (7,'A13','R3','C5',5,2),
  (8,'A7','R6','C3',12,2),
  (9,'A8','R4','C4',94,5),
  (10,'A9','R1','C5',15,18),
  (11,'A10','R2','C6',5,2),
  (12,'A11','R5','C5',9,6),
  (13,'A12','R4','C5',45,7);

DROP TABLE IF EXISTS restaurants;
CREATE TABLE restaurants (
  restaurant_id VARCHAR PRIMARY KEY,
  area VARCHAR NOT NULL,
  name VARCHAR NOT NULL,
  cuisine_type VARCHAR NOT NULL,
  avg_preparation_time_min FLOAT
);

-- Insert sample data
INSERT INTO restaurants (restaurant_id, area, name, cuisine_type, avg_preparation_time_min) VALUES
  ('R1','A','Rel','Asian',15),
  ('R2','B','Pri','Italian',20),
  ('R3','C','Des','Mexican',40),
  ('R4','A','Bor','Italian',3),
  ('R5','D','Ran','Mexican',40),
  ('R6','E','Del','Italian',3);
  
DROP TABLE IF EXISTS delivery_persons;
CREATE TABLE delivery_persons (
  delivery_person_id VARCHAR PRIMARY KEY,
  name VARCHAR NOT NULL,
  region VARCHAR NOT NULL,
  hired_date DATE NOT NULL,
  is_active BOOLEAN
);

-- Insert sample data
INSERT INTO delivery_persons (delivery_person_id, name, region, hired_date, is_active) VALUES
  (1,'Alex','B','5/9/2026','Y'),
  (2,'Alfonso','C','7/8/2025','N'),
  (3,'Rachel','A','4/6/2026','Y'),
  (4,'Tatiana','B','1/5/2026','Y');
  
DROP TABLE IF EXISTS deliveries;
CREATE TABLE deliveries (
  delivery_id VARCHAR PRIMARY KEY,
  delivery_person_id VARCHAR NOT NULL,
  restaurant_area VARCHAR NOT NULL,
  customer_area VARCHAR NOT NULL,
  delivery_distance_km FLOAT,
  delivery_time_min INTEGER,
  order_placed_at timestamp,
  weather_condition VARCHAR,
  traffic_condition VARCHAR,
  delivery_rating FLOAT
);

-- Insert sample data
INSERT INTO deliveries (delivery_id, delivery_person_id, restaurant_area, 
					   customer_area, delivery_distance_km, delivery_time_min,
					   order_placed_at, weather_condition,traffic_condition,
					   delivery_rating) VALUES
  ('A1',1,'A','B',40,15,'2026-11-05 09:00:30.75','Sunny','Heavy',5),
  ('A2',2,'B','C',30,12,'2026-08-07 15:00:30.75','Cloudy','Heavy',4.9),
  ('A3',3,'A','E',20,10,'2026-09-06 15:00:42.75','Cloudy','Light',4.5),
  ('A4',4,'A','A',10,19,'2026-11-05 03:00:30.75','Rain','Average',4),
  ('A5',1,'A','C',5,12,'2026-05-09 03:30:45.75','Sunny','Heavy',2),
  ('A6',2,'B','E',45,14,'2026-10-09 06:30:45.25','Sunny','Light',5),
  ('A7',4,'E','F',11,18,'2026-02-05 03:00:36.75','Rain','Average',4),
  ('A8',1,'A','D',5,10,'2026-10-10 03:10:45.75','Sunny','Heavy',2),
  ('A9',2,'A','A',50,14,'2026-10-09 08:25:45.75','Sunny','Light',4.5),
  ('A10',4,'B','A',10,10,'2026-01-22 03:00:30.75','Rain','Average',4),
  ('A11',1,'D','C',5,13,'2026-9-09 03:30:45.75','Sunny','Heavy',2.5),
  ('A12',2,'A','E',45,14,'2025-11-09 06:30:45.25','Sunny','Light',5);
  
-- Query the data 
--1. Top 5 customer areas with highest average delivery time in the last 30 days. 
SELECT customer_area, avg(delivery_time_min) AS avg_delivery_time_min
	  from deliveries
	  WHERE order_placed_at > current_date - interval '30' day
	  group by customer_area
	  order by avg_delivery_time_min desc
	  limit 5;

--2. Average delivery time per traffic condition, by restaurant area and cuisine type. 
SELECT restaurant_area, 
	cuisine_type, 
	avg(CASE WHEN traffic_condition = 'Light' THEN delivery_time_min ELSE 0 END) AS "Light",
    avg(CASE WHEN traffic_condition = 'Average' THEN delivery_time_min ELSE 0 END) AS "Average",
	avg(CASE WHEN traffic_condition = 'Heavy' THEN delivery_time_min ELSE 0 END) AS "Heavy"
FROM (SELECT * FROM (SELECT delivery_id, cuisine_type
FROM orders LEFT JOIN restaurants USING(restaurant_id)) 
RIGHT JOIN deliveries USING(delivery_id)) 
group by restaurant_area, cuisine_type
order by restaurant_area, cuisine_type;

--3. Top 10 delivery people with the fastest average delivery time, considering only those with at least 50 deliveries 
--and who are still active. 
select * from (select delivery_person_id, name from ((select delivery_person_id,count(delivery_person_id) AS delivery_count
from deliveries
group by delivery_person_id) left join delivery_persons using (delivery_person_id)) 
where delivery_count>=50 AND is_active='Y') left join (
SELECT delivery_person_id, avg(delivery_time_min) AS avg_delivery_time_min 
from deliveries
group by delivery_person_id
limit 10) using (delivery_person_id)
order by avg_delivery_time_min asc;

--4. The most profitable restaurant area in the last 3 months, defined as the area with the highest total order value. 
select restaurant_area, sum(order_value) as sum_order_value from (orders left join restaurants using (restaurant_id)) 
right join deliveries using (delivery_id)
WHERE order_placed_at  >  CURRENT_DATE - INTERVAL '3 months'
group by restaurant_area
limit 1;

--5. Identify whether any delivery people show an increasing trend in average delivery time.
SELECT delivery_person_id, 
       STRING_AGG(avg_time_per_month::text, ', ' ORDER BY Month) = STRING_AGG(avg_time_per_month::text, ', ' ORDER BY avg_time_per_month) value_is_increasing
FROM (SELECT    delivery_person_id,
          Avg(delivery_time_min) as avg_time_per_month,
          DATE_TRUNC('month', order_placed_at) as month
FROM      deliveries
GROUP BY  delivery_person_id,
          month
order by month)
GROUP BY delivery_person_id
HAVING COUNT(*) > 1
AND COUNT(*) = COUNT(DISTINCT Month);


