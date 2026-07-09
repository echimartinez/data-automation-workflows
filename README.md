# Data Automation & Analytics Portfolio

A collection of real-world data automation workflows, SQL analytics queries, and AI-powered pipelines built to demonstrate practical skills in data engineering and process automation.

---

## 📁 Project Structure

```
data-automation-workflows/
│
├── sql/
│   ├── chicago_taxi_kpi_queries.sql   # KPI & SLA analytics on BigQuery public dataset
│   └── README.md
│
├── n8n/
│   ├── sheets_monitor_email_notifier.json   # Google Sheets monitor + email notifier
│   └── README.md
│
└── ai-pipelines/
    ├── ai_data_classifier.json   # Claude API + n8n classifier
    └── README.md
```

---

## 🗂️ Projects

### 📊 01. Chicago Taxi Trips — KPI & SLA Analytics
**Folder:** [`sql/`](./sql/)
**Dataset:** `bigquery-public-data.chicago_taxi_trips.taxi_trips`

A set of production-ready SQL queries for BigQuery that simulate real FinOps and operations reporting. Built to reflect the kind of analytical work done in large-scale data environments.

**Queries included:**

| # | Query | Description |
|---|-------|-------------|
| 01 | Daily Revenue KPI | Total revenue, trips and avg fare per day |
| 02 | Monthly Revenue Trend | MoM comparison with growth rate using window functions |
| 03 | SLA Compliance | Trip duration classification: On Time / Delayed / Critical |
| 04 | Top 10 Companies | Revenue ranking with avg fare and mileage |
| 05 | Hourly Demand Heatmap | Trips by hour and day of week |
| 06 | Full KPI Dashboard | Single query summary for executive reporting |

**Key SQL concepts:** CTEs · Window functions · Conditional aggregation · Timestamp operations · Null-safe division

---

### 🔄 02. Google Sheets Monitor & Email Notifier
**Folder:** [`n8n/`](./n8n/)

An n8n automation workflow that monitors a Google Sheet on a schedule, detects pending items, and sends automatic email notifications to the team.

**Flow:**
```
Schedule Trigger (every 1h) → Read Google Sheet → Filter Pending Items
→ Aggregate Results → Build Email Content → Send Email Notification
```

**Key concepts:** Scheduled automation · Data filtering · Dynamic email generation · Event-driven workflows

---

### 🤖 03. AI-Powered Data Classifier with Claude API
**Folder:** [`ai-pipelines/`](./ai-pipelines/)

An n8n workflow that receives free text via webhook, sends it to Claude API for intelligent classification, and automatically saves the structured result to a Google Sheet.

**Flow:**
```
Webhook (POST) → Prepare Prompt → Call Claude API
→ Parse Response → Save to Google Sheet → Return Result
```

**Output per item:** category · priority · summary · sentiment

**Key concepts:** Webhook trigger · LLM integration · Prompt engineering · Structured JSON output · AI + automation pipelines

---

## 🛠️ Tech Stack

![BigQuery](https://img.shields.io/badge/BigQuery-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![n8n](https://img.shields.io/badge/n8n-EA4B71?style=for-the-badge&logo=n8n&logoColor=white)
![Claude](https://img.shields.io/badge/Claude_API-D97757?style=for-the-badge&logo=anthropic&logoColor=white)
![Google Sheets](https://img.shields.io/badge/Google_Sheets-34A853?style=for-the-badge&logo=google-sheets&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

---

## 👤 Author

**Ezequiel Martinez** — Data Analyst & Automation Developer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ezequiel-martinez-421bb91b0)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/echimartinez)
