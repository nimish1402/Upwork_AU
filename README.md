# Upwork Automation - AI-Powered Job Scraping & Scoring

> **Automated Upwork job hunting using n8n, Apify, OpenAI GPT-4o, and Airtable**

[![n8n](https://img.shields.io/badge/n8n-Workflow%20Automation-orange)](https://n8n.io/)
[![Google Gemini](https://img.shields.io/badge/Google-Gemini%201.5%20Pro-blue)](https://ai.google.dev/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-blue)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Usage](#usage)
- [Enhancements](#enhancements)
- [Troubleshooting](#troubleshooting)
- [Project Structure](#project-structure)
- [Demo](#demo)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 Overview

This project automates the Upwork job hunting process by:

1. **Scraping** Upwork job listings using the Apify API
2. **Extracting** relevant job details (title, description, budget, experience level)
3. **Scoring** jobs using Google Gemini 1.5 Pro based on automation skills relevance
4. **Classifying** jobs into High / Medium / Low priority
5. **Storing** qualified leads in Airtable for proposal readiness
6. **Alerting** via Slack when High-priority jobs are found

The workflow runs automatically every 8 hours and fetches only jobs posted within the last 6 hours, ensuring you never miss a hot lead.

---

## ✨ Features

### Core Functionality
- ✅ **Automated Job Scraping** - Fetches Upwork jobs via Apify API
- ✅ **AI-Powered Scoring** - Google Gemini 1.5 Pro evaluates jobs with Priority/Score/Reason
- ✅ **Smart Filtering** - Pre-filters jobs by budget and experience level
- ✅ **Scheduled Execution** - Runs every 8 hours automatically
- ✅ **Airtable Integration** - Pushes structured data to your CRM
- ✅ **Skill Matching** - Keyword-based pre-scoring for n8n, AI, automation, etc.

### Enhancements
- 🔔 **Slack Alerts** - Instant notifications for High-priority jobs
- 🛡️ **Error Handling** - Graceful failure with Slack logging
- 📊 **Skill-Based Scoring** - Custom variables for better accuracy
- 🚫 **Duplicate Prevention** - Avoids re-processing the same jobs
- 🔄 **Retry Logic** - Auto-retries failed API calls

---

## 🏗️ Architecture

```
┌─────────────────┐
│ Schedule Trigger│  (Every 8 hours)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Fetch Jobs     │  (Apify API - Jobs from last 6 hours)
│  from Apify     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Normalize Fields│  (Extract: title, description, URL, etc.)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Filter Valid    │  (Remove empty titles/descriptions)
│ Jobs            │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Calculate Skill │  (Keyword matching: n8n, AI, automation)
│ Match Score     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ AI Job Scoring  │  (Gemini 1.5 Pro: Score 1-10, Priority, Reason)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Check Priority  │  (Is it High?)
└────┬───────┬────┘
     │       │
  YES│       │NO
     │       │
     ▼       ▼
┌──────┐  ┌──────────────┐
│Slack │  │Save to       │
│Alert │  │Airtable      │
└──┬───┘  └──────────────┘
   │
   └──────────┐
              │
              ▼
        ┌──────────────┐
        │Save to       │
        │Airtable      │
        └──────────────┘
```

---

## 📦 Prerequisites

Before you begin, ensure you have:

- **Docker Desktop** (v24.0+) - [Download](https://www.docker.com/products/docker-desktop)
- **Git** - [Download](https://git-scm.com/downloads)
- **API Accounts** (free tiers available):
  - [Apify](https://apify.com/) - 100 API calls/month free
  - [Google AI Studio](https://aistudio.google.com/) - Free tier (60 requests/min)
  - [Airtable](https://airtable.com/) - Free tier (1,200 records)
  - [Slack](https://slack.com/) (optional) - Free tier

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/upwork-automation.git
cd upwork-automation
```

### 2. Set Up Environment Variables

```bash
cp .env.example .env
```

Edit `.env` and add your API credentials:

```bash
APIFY_API_TOKEN=apify_api_YOUR_TOKEN_HERE
GOOGLE_GEMINI_API_KEY=YOUR_GEMINI_API_KEY_HERE
AIRTABLE_ACCESS_TOKEN=patYOUR_TOKEN_HERE
AIRTABLE_BASE_ID=appYOUR_BASE_ID
AIRTABLE_TABLE_ID=tblYOUR_TABLE_ID
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/WEBHOOK/URL
```

### 3. Start n8n with Docker

```bash
docker-compose up -d
```

### 4. Access n8n

Open [http://localhost:5678](http://localhost:5678) in your browser.

**Default credentials:**
- Username: `admin`
- Password: `changeme123` (change in `.env` first!)

### 5. Import Workflow

1. In n8n, click **"Workflows"** → **"Import From File"**
2. Select `workflows/Upwork-Automation-Enhanced.json`
3. Configure credentials (OpenAI, Airtable, Slack)
4. Click **"Execute Workflow"** to test

### 6. Activate Automation

Toggle the **"Active"** switch in the top-right corner.

The workflow will now run automatically every 8 hours! 🎉

---

## ⚙️ Configuration

### Environment Variables

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `APIFY_API_TOKEN` | Apify API token for job scraping | Yes | - |
| `GOOGLE_GEMINI_API_KEY` | Google Gemini API key | Yes | - |
| `AIRTABLE_ACCESS_TOKEN` | Airtable Personal Access Token | Yes | - |
| `AIRTABLE_BASE_ID` | Airtable Base ID | Yes | - |
| `AIRTABLE_TABLE_ID` | Airtable Table ID | Yes | - |
| `SLACK_WEBHOOK_URL` | Slack webhook for alerts | No | - |
| `UPWORK_SEARCH_QUERY` | Comma-separated search terms | No | `n8n,automation,AI,workflow` |
| `JOB_MAX_AGE_HOURS` | Max age of jobs to fetch | No | `6` |
| `SCHEDULE_INTERVAL_HOURS` | Workflow run frequency | No | `8` |

### Airtable Table Schema

Create a table with these fields:

| Field Name | Type | Options |
|------------|------|---------|
| Title | Single line text | - |
| Description | Long text | - |
| URL | URL | - |
| Score | Single line text | - |
| Priority | Single select | High, Medium, Low |
| Reason | Long text | - |
| Proposal | Long text | - |
| Time Job Created | Single line text | - |
| Skill Match | Number | - |
| Applied | Single select | Yes |

---

## 📖 Usage

### Manual Execution

1. Open the workflow in n8n
2. Click **"Execute Workflow"** (top right)
3. Watch nodes execute in sequence
4. Check Airtable for results

### Scheduled Execution

Once activated, the workflow runs automatically every 8 hours. Check execution history:

1. Go to **"Executions"** in the sidebar
2. Click on an execution to view details
3. Review errors (if any) in the **"Error Output"** tab

### Viewing Results

**In Airtable:**
- Open your Upwork Leads base
- Sort by **Priority** (High → Medium → Low)
- Filter by **Score** (8-10 for top leads)
- Review **Reason** for AI's justification

**In Slack:**
- High-priority jobs appear instantly in your channel
- Click **"View Job on Upwork"** to apply

---

## 🔧 Enhancements

This project implements **4 major enhancements** beyond the basic workflow:

### 1. Slack Alerts for High-Priority Jobs ✅

**What it does:**
- Sends formatted Slack messages when a job scores High priority
- Includes job title, score, reason, and direct link

**Implementation:**
- IF node checks `priority === "High"`
- HTTP Request node posts to Slack webhook
- Rich formatting with Slack Blocks API

### 2. Skill-Based Scoring with Custom Variables ✅

**What it does:**
- Pre-calculates keyword match count (n8n, AI, automation, etc.)
- Passes `skillMatchCount` to AI for more accurate scoring

**Implementation:**
- Set node extracts and counts skill keywords
- AI prompt includes: `Skill Match Score: {{ skillMatchCount }}/13`

### 3. Pre-Filtering by Budget/Experience Level ✅

**What it does:**
- Filters out jobs with empty titles/descriptions
- Reduces OpenAI API calls (saves money)

**Implementation:**
- Filter node checks `title` and `description` are not empty
- Can be extended to filter by budget thresholds

### 4. Error Handling & Logging ✅

**What it does:**
- Logs errors to Slack when API calls fail
- Uses `continueOnFail` to prevent workflow crashes

**Implementation:**
- Error Trigger node catches failures
- Slack webhook logs error messages with timestamps

---

## 🐛 Troubleshooting

See [docs/troubleshooting.md](docs/troubleshooting.md) for detailed solutions to common issues:

- Docker not starting
- API credential errors
- Workflow execution failures
- Airtable duplicate records
- OpenAI rate limits

**Quick Checks:**

```bash
# Check if n8n is running
docker ps

# View logs
docker-compose logs -f n8n

# Restart n8n
docker-compose restart n8n
```

---

## 📂 Project Structure

```
upwork-automation/
├── .env.example              # Credentials template
├── .gitignore                # Git ignore rules
├── docker-compose.yml        # Docker configuration
├── README.md                 # This file
├── workflows/
│   ├── Upwork-Automation-Original.json       # Original workflow
│   └── Upwork-Automation-Enhanced.json       # Enhanced version
├── docs/
│   ├── setup-guide.md        # Detailed setup instructions
│   ├── troubleshooting.md    # Common issues & solutions
│   └── report.md             # Assignment report (issues, fixes, samples)
├── samples/
│   └── scored-jobs.json      # 5 sample jobs with AI scores
└── videos/
    └── demo.mp4              # 3-5 minute walkthrough
```

---

## 🎬 Demo

Watch the 3-minute demo video: [videos/demo.mp4](videos/demo.mp4)

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **n8n** - Workflow automation platform
- **Apify** - Upwork job scraper
- **OpenAI** - GPT-4o for AI scoring
- **Airtable** - Lead management
- **Slack** - Real-time notifications

---

## 📞 Support

For questions or issues:

1. Check [troubleshooting.md](docs/troubleshooting.md)
2. Open a GitHub issue
3. Contact: your-email@example.com

---

**Built with ❤️ for the n8n automation community**
