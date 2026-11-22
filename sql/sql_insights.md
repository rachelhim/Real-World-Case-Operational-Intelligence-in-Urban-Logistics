Started with SQLite syntax and then moved to Postgres syntax so that is the reason from some unusual function usage

For question 4 I deduced that last 3 months were the whole 3 last months not counting the one currently in, however, if its last 90 days the corresponding query would be:
select restaurant_area, sum(order_value) as sum_order_value from (orders left join restaurants using (restaurant_id)) 
right join deliveries using (delivery_id)
WHERE order_placed_at  >  CURRENT_DATE - INTERVAL '90 days'
group by restaurant_area
limit 1;

Similar for number 5, I aggregated the data for month for simplicity, however if the trend was analyzed by day, hour , semester or year, the query can easily be adapted.