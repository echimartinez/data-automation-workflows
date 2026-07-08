# Google Sheets Monitor & Email Notifier

An n8n automation workflow that monitors a Google Sheet on a schedule, detects pending items, and sends automatic email notifications to the team.

---

## 📋 How it works

```
Schedule Trigger (every 1h)
        ↓
Read Google Sheet
        ↓
Filter Pending Items  ←— only rows where status = "pending"
        ↓
Aggregate Results
        ↓
Build Email Content   ←— formats subject + body dynamically
        ↓
Has Pending Items?    ←— skip if nothing to report
        ↓
Send Email Notification
```

---

## 🔧 Nodes

| Node | Type | Purpose |
|------|------|---------|
| Schedule Trigger | Trigger | Runs the workflow every hour |
| Read Google Sheet | Google Sheets | Fetches all rows from the spreadsheet |
| Filter Pending Items | Filter | Keeps only rows with `status = "pending"` |
| Aggregate Results | Aggregate | Groups all filtered rows into a single object |
| Build Email Content | Code (JS) | Formats the email subject and body dynamically |
| Has Pending Items? | Filter | Stops execution if no pending items found |
| Send Email Notification | Gmail | Sends the alert email |

---

## ⚙️ Setup

### 1. Import the workflow
- Open n8n
- Go to **Workflows → Import**
- Upload `sheets_monitor_email_notifier.json`

### 2. Configure credentials
- **Google Sheets** — connect your Google account with Sheets access
- **Gmail** — connect your Gmail account

### 3. Configure the workflow
- In **Read Google Sheet** → replace `YOUR_GOOGLE_SHEET_ID` with your actual Sheet ID
- In **Send Email Notification** → replace `your-email@example.com` with the recipient
- In **Filter Pending Items** → adjust the filter field/value to match your Sheet columns

### 4. Expected Sheet structure

| name | status | date |
|------|--------|------|
| Invoice #001 | pending | 2024-01-15 |
| Invoice #002 | approved | 2024-01-16 |
| Invoice #003 | pending | 2024-01-17 |

### 5. Activate
- Toggle the workflow to **Active**
- It will run automatically every hour

---

## 📧 Example email output

```
Subject: [Alert] 2 Pending Item(s) Detected — 1/17/2024

Hi,

The following 2 item(s) are currently pending review:

1. Invoice #001 — Status: pending — Date: 2024-01-15
2. Invoice #003 — Status: pending — Date: 2024-01-17

Please take action as needed.

This is an automated notification.
```

---

## 🛠️ Tech Stack

![n8n](https://img.shields.io/badge/n8n-EA4B71?style=for-the-badge&logo=n8n&logoColor=white)
![Google Sheets](https://img.shields.io/badge/Google_Sheets-34A853?style=for-the-badge&logo=google-sheets&logoColor=white)
![Gmail](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

---

## 👤 Author

**Ezequiel Martinez** — Data Analyst & Automation Developer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ezequiel-martinez-421bb91b0)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/echimartinez)
