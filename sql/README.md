# SQL Analytics — Chicago Taxi Trips

A set of production-ready SQL queries for BigQuery that simulate real FinOps and operations reporting, built on the public dataset `bigquery-public-data.chicago_taxi_trips.taxi_trips`.

---

## 📂 File

| File | Description |
|------|-------------|
| `chicago_taxi_kpi_queries.sql` | KPI & SLA analytics queries |

---

## 📊 Queries included

| # | Query | Description |
|---|-------|-------------|
| 01 | Daily Revenue KPI | Total revenue, trips and avg fare per day |
| 02 | Monthly Revenue Trend | MoM comparison with growth rate using window functions |
| 03 | SLA Compliance | Trip duration classification: On Time / Delayed / Critical |
| 04 | Top 10 Companies | Revenue ranking with avg fare and mileage |
| 05 | Hourly Demand Heatmap | Trips by hour and day of week |
| 06 | Full KPI Dashboard | Single query summary for executive reporting |

---

## ⚙️ Setup

1. Open [BigQuery Console](https://console.cloud.google.com/bigquery)
2. The dataset is publicly available — no setup needed:
   ```
   bigquery-public-data.chicago_taxi_trips.taxi_trips
   ```
3. Copy and run any query from `chicago_taxi_kpi_queries.sql`

---

## 🔑 Key SQL concepts used

- CTEs (`WITH` clauses)
- Window functions (`LAG`, `OVER`)
- Conditional aggregation (`COUNTIF`)
- Timestamp operations (`TIMESTAMP_DIFF`, `FORMAT_TIMESTAMP`, `EXTRACT`)
- Null-safe division (`NULLIF`)

---

## 🛠️ Tech Stack

![BigQuery](https://img.shields.io/badge/BigQuery-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

---

## 👤 Author

**Ezequiel Martinez** — Data Analyst & Automation Developer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ezequiel-martinez-421bb91b0)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/echimartinez)
