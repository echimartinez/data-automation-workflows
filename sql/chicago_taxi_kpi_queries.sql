-- ============================================================
-- Chicago Taxi Trips — KPI & Analytics Queries
-- Dataset: bigquery-public-data.chicago_taxi_trips.taxi_trips
-- Author: Ezequiel Martinez
-- ============================================================


-- ============================================================
-- 01. DAILY REVENUE KPI
-- Total revenue, number of trips and average fare per day
-- ============================================================
SELECT
  DATE(trip_start_timestamp) AS trip_date,
  COUNT(*)                   AS total_trips,
  ROUND(SUM(fare), 2)        AS total_revenue,
  ROUND(AVG(fare), 2)        AS avg_fare,
  ROUND(SUM(tips), 2)        AS total_tips,
  ROUND(SUM(fare + tips), 2) AS total_collected
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE
  trip_start_timestamp >= TIMESTAMP('2023-01-01')
  AND trip_start_timestamp < TIMESTAMP('2024-01-01')
  AND fare > 0
GROUP BY
  trip_date
ORDER BY
  trip_date;


-- ============================================================
-- 02. MONTHLY REVENUE TREND
-- Month-over-month revenue comparison with growth rate
-- ============================================================
WITH monthly_revenue AS (
  SELECT
    FORMAT_TIMESTAMP('%Y-%m', trip_start_timestamp) AS month,
    COUNT(*)                                         AS total_trips,
    ROUND(SUM(fare), 2)                              AS total_revenue
  FROM
    `bigquery-public-data.chicago_taxi_trips.taxi_trips`
  WHERE
    trip_start_timestamp >= TIMESTAMP('2022-01-01')
    AND trip_start_timestamp < TIMESTAMP('2024-01-01')
    AND fare > 0
  GROUP BY
    month
)
SELECT
  month,
  total_trips,
  total_revenue,
  LAG(total_revenue) OVER (ORDER BY month)  AS prev_month_revenue,
  ROUND(
    (total_revenue - LAG(total_revenue) OVER (ORDER BY month))
    / NULLIF(LAG(total_revenue) OVER (ORDER BY month), 0) * 100,
    2
  )                                          AS revenue_growth_pct
FROM
  monthly_revenue
ORDER BY
  month;


-- ============================================================
-- 03. SLA — TRIP DURATION COMPLIANCE
-- Classify trips by duration SLA: On Time / Delayed / Critical
-- ============================================================
WITH trip_duration AS (
  SELECT
    unique_key,
    DATE(trip_start_timestamp)                                     AS trip_date,
    trip_miles,
    TIMESTAMP_DIFF(trip_end_timestamp, trip_start_timestamp, MINUTE) AS duration_minutes,
    fare,
    company
  FROM
    `bigquery-public-data.chicago_taxi_trips.taxi_trips`
  WHERE
    trip_start_timestamp >= TIMESTAMP('2023-01-01')
    AND trip_start_timestamp < TIMESTAMP('2024-01-01')
    AND trip_end_timestamp > trip_start_timestamp
    AND trip_miles > 0
)
SELECT
  trip_date,
  COUNT(*)                                                              AS total_trips,
  COUNTIF(duration_minutes <= 30)                                       AS on_time,
  COUNTIF(duration_minutes > 30 AND duration_minutes <= 60)             AS delayed,
  COUNTIF(duration_minutes > 60)                                        AS critical,
  ROUND(COUNTIF(duration_minutes <= 30) / COUNT(*) * 100, 2)            AS sla_compliance_pct
FROM
  trip_duration
GROUP BY
  trip_date
ORDER BY
  trip_date;


-- ============================================================
-- 04. TOP 10 COMPANIES BY REVENUE
-- Ranking of taxi companies by total revenue and avg fare
-- ============================================================
SELECT
  company,
  COUNT(*)                   AS total_trips,
  ROUND(SUM(fare), 2)        AS total_revenue,
  ROUND(AVG(fare), 2)        AS avg_fare,
  ROUND(AVG(trip_miles), 2)  AS avg_miles,
  ROUND(SUM(tips), 2)        AS total_tips
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE
  trip_start_timestamp >= TIMESTAMP('2023-01-01')
  AND trip_start_timestamp < TIMESTAMP('2024-01-01')
  AND fare > 0
  AND company IS NOT NULL
GROUP BY
  company
ORDER BY
  total_revenue DESC
LIMIT 10;


-- ============================================================
-- 05. HOURLY DEMAND HEATMAP
-- Number of trips by hour of day and day of week
-- ============================================================
SELECT
  EXTRACT(DAYOFWEEK FROM trip_start_timestamp) AS day_of_week,
  EXTRACT(HOUR FROM trip_start_timestamp)      AS hour_of_day,
  COUNT(*)                                     AS total_trips,
  ROUND(AVG(fare), 2)                          AS avg_fare
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE
  trip_start_timestamp >= TIMESTAMP('2023-01-01')
  AND trip_start_timestamp < TIMESTAMP('2024-01-01')
  AND fare > 0
GROUP BY
  day_of_week,
  hour_of_day
ORDER BY
  day_of_week,
  hour_of_day;


-- ============================================================
-- 06. FULL KPI DASHBOARD — SINGLE QUERY
-- Summary of all key metrics for executive reporting
-- ============================================================
SELECT
  FORMAT_TIMESTAMP('%Y-%m', trip_start_timestamp)                        AS month,
  COUNT(*)                                                                AS total_trips,
  ROUND(SUM(fare), 2)                                                     AS total_revenue,
  ROUND(AVG(fare), 2)                                                     AS avg_fare,
  ROUND(AVG(trip_miles), 2)                                               AS avg_miles,
  ROUND(AVG(
    TIMESTAMP_DIFF(trip_end_timestamp, trip_start_timestamp, MINUTE)
  ), 2)                                                                   AS avg_duration_minutes,
  ROUND(SUM(tips) / NULLIF(SUM(fare), 0) * 100, 2)                       AS tip_rate_pct,
  ROUND(COUNTIF(
    TIMESTAMP_DIFF(trip_end_timestamp, trip_start_timestamp, MINUTE) <= 30
  ) / COUNT(*) * 100, 2)                                                  AS sla_compliance_pct
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE
  trip_start_timestamp >= TIMESTAMP('2023-01-01')
  AND trip_start_timestamp < TIMESTAMP('2024-01-01')
  AND fare > 0
  AND trip_end_timestamp > trip_start_timestamp
GROUP BY
  month
ORDER BY
  month;
