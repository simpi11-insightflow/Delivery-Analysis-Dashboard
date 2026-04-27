/*Food delivery Performance Analysis using SQL
Multiple Factor Impact on Delivery Time */
SELECT traffic_level,vehicle_type,peak_non_peak,
       ROUND(AVG(delivery_time_min),2) AS avg_time
FROM delivery_data
GROUP BY traffic_level,vehicle_type,peak_non_peak
ORDER BY avg_time DESC;


/*Order Volume vs Delivery 
Performance by Hour (Bottleneck Detection) */
SELECT hour, COUNT(*) AS total_orders,
       ROUND(AVG(delivery_time_min),2) AS avg_time
FROM delivery_data
GROUP BY hour
ORDER BY total_orders DESC;

  
  /*SLA Breach Analysis(On time vs delayed deliveries */
SELECT sla_breach,
       COUNT(*) AS total_orders,
ROUND(AVG(delivery_time_min),2) AS avg_time
FROM delivery_data
GROUP BY sla_breach;


/* Rider Performance Ranking based on Efficiency and Delivery Time */
SELECT riderid,
       COUNT(*) AS total_orders,
ROUND(AVG(delivery_time_min),2) AS avg_time,
     ROUND(AVG(efficiency_score) ::numeric,2) AS efficiency
FROM delivery_data
GROUP BY riderid
ORDER BY efficiency DESC
LIMIT 10;


/* Impact of Rider Load on Delivery Efficiency and Speed */
SELECT rider_load,
ROUND(AVG(delivery_time_min),2) AS avg_time,
     ROUND(AVG(efficiency_score) ::numeric,2) AS efficiency
FROM delivery_data
GROUP BY rider_load
ORDER BY rider_load;


/* Weather Condition Impact on Delivery Time */
SELECT weather,
ROUND(AVG(delivery_time_min),2)AS avg_time
FROM delivery_data
GROUP BY weather 
ORDER BY avg_time DESC;


/* Vehicle Type Performance Comparision (Fastest Delivery Mode) */
SELECT vehicle_type,
ROUND(AVG(delivery_time_min),2)AS avg_time
FROM delivery_data
GROUP BY vehicle_type
ORDER BY avg_time;


/*Efficiency Segmentation Analysis(High,Medium and Low Performance) */
SELECT CASE WHEN efficiency_score>120 THEN 'High Efficiency'
            WHEN efficiency_score BETWEEN 80 AND 120 THEN 'Medium'
			ELSE 'low Efficiency'
			END AS efficiency_group,
ROUND(AVG(delivery_time_min),2)AS avg_time
FROM delivery_data
GROUP BY efficiency_group;


/*Delivery Speed Classification (Fast vs Medium vs Slow Orders) */
SELECT CASE WHEN delivery_time_min<=40 THEN 'Fast'
            WHEN delivery_time_min<=70 THEN 'Medium'
			ELSE 'Slow'
			END AS delivery_speed,
			COUNT(*) AS total_orders
FROM delivery_data
GROUP BY delivery_speed;



/*Worst Case Scenario Analysis (Peak Hours + High Traffic Delays) */
SELECT * 
FROM delivery_data
WHERE peak_non_peak='Peak'
AND traffic_level='High'
ORDER BY delivery_time_min DESC
LIMIT 10;
