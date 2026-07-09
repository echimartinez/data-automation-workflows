# AI-Powered Data Classifier with Claude API

An n8n workflow that receives free text via webhook, sends it to Claude API for intelligent classification, and automatically saves the structured result to a Google Sheet.

---

## 📋 How it works

```
Webhook (POST /classify-data)
        ↓
Prepare Prompt        ←— builds the classification prompt
        ↓
Call Claude API       ←— sends request to claude-haiku-4-5
        ↓
Parse Claude Response ←— extracts and validates JSON output
        ↓
Save to Google Sheet  ←— stores structured result
        ↓
Send Response         ←— returns classification to caller
```

---

## 🔧 Nodes

| Node | Type | Purpose |
|------|------|---------|
| Webhook Trigger | Webhook | Receives POST requests with text to classify |
| Prepare Prompt | Code (JS) | Builds the structured prompt for Claude |
| Call Claude API | HTTP Request | Calls Anthropic API with the prompt |
| Parse Claude Response | Code (JS) | Parses JSON response and enriches data |
| Save to Google Sheet | Google Sheets | Persists the classification result |
| Send Response | Respond to Webhook | Returns the result to the caller |

---

## 📤 Input

Send a POST request to the webhook URL:

```json
{
  "text": "I have been waiting for my order for 3 weeks and nobody has answered my emails. This is unacceptable.",
  "source": "email"
}
```

## 📥 Output

```json
{
  "success": true,
  "result": {
    "category": "complaint",
    "priority": "high",
    "summary": "Customer frustrated after 3-week wait with no support response.",
    "sentiment": "negative"
  }
}
```

---

## 🗂️ Google Sheet structure

The workflow saves each classification as a new row:

| received_at | processed_at | source | original_text | category | priority | summary | sentiment | model_used | tokens_used |
|-------------|--------------|--------|---------------|----------|----------|---------|-----------|------------|-------------|
| 2024-01-17T... | 2024-01-17T... | email | I have been waiting... | complaint | high | Customer frustrated... | negative | claude-haiku-4-5 | 187 |

---

## ⚙️ Setup

### 1. Import the workflow
- Open n8n
- Go to **Workflows → Import**
- Upload `ai_data_classifier.json`

### 2. Configure credentials

**Anthropic API Key:**
- Go to [console.anthropic.com](https://console.anthropic.com) and generate an API key
- In n8n, create a new **HTTP Header Auth** credential:
  - Name: `x-api-key`
  - Value: `your-anthropic-api-key`

**Google Sheets:**
- Connect your Google account with Sheets access
- Create a Sheet named `Classifications` with the columns listed above

### 3. Configure the workflow
- In **Save to Google Sheet** → replace `YOUR_GOOGLE_SHEET_ID` with your actual Sheet ID

### 4. Test it

```bash
curl -X POST https://your-n8n-instance/webhook/classify-data \
  -H "Content-Type: application/json" \
  -d '{"text": "The product arrived damaged and I need a replacement.", "source": "test"}'
```

### 5. Activate
- Toggle the workflow to **Active**

---

## 🎯 Use cases

- Customer support ticket classification
- Email triage and prioritization
- Feedback categorization
- Operations alert classification

---

## 🛠️ Tech Stack

![n8n](https://img.shields.io/badge/n8n-EA4B71?style=for-the-badge&logo=n8n&logoColor=white)
![Claude](https://img.shields.io/badge/Claude_API-D97757?style=for-the-badge&logo=anthropic&logoColor=white)
![Google Sheets](https://img.shields.io/badge/Google_Sheets-34A853?style=for-the-badge&logo=google-sheets&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

---

## 👤 Author

**Ezequiel Martinez** — Data Analyst & Automation Developer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ezequiel-martinez-421bb91b0)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/echimartinez)
