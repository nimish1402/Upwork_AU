# Setup Guide - Upwork Automation

## Prerequisites

Before starting, ensure you have:

- **Docker Desktop** installed ([Download here](https://www.docker.com/products/docker-desktop))
- **Git** installed ([Download here](https://git-scm.com/downloads))
- API accounts for:
  - Apify (free tier)
  - OpenAI (pay-as-you-go)
  - Airtable (free tier)
  - Slack (optional, free tier)

---

## Step 1: Clone the Repository

```bash
git clone <your-repo-url>
cd upwork-automation
```

---

## Step 2: Configure Credentials

### 2.1 Copy Environment Template

```bash
cp .env.example .env
```

### 2.2 Get Apify API Token

1. Go to [Apify Console](https://console.apify.com/)
2. Sign up or log in
3. Navigate to **Settings** → **Integrations**
4. Copy your API token
5. Paste it in `.env` as `APIFY_API_TOKEN`

### 2.3 Get OpenAI API Key

1. Go to [OpenAI Platform](https://platform.openai.com/)
2. Sign up or log in
3. Navigate to **API Keys**
4. Click **Create new secret key**
5. Copy the key (it won't be shown again!)
6. Paste it in `.env` as `OPENAI_API_KEY`

### 2.4 Get Airtable Access Token

1. Go to [Airtable](https://airtable.com/)
2. Sign up or log in
3. Navigate to **Account** → **Developer hub**
4. Click **Create token**
5. Give it a name (e.g., "n8n Upwork Automation")
6. Select scopes:
   - `data.records:read`
   - `data.records:write`
   - `schema.bases:read`
7. Select your base (or grant access to all bases)
8. Copy the token
9. Paste it in `.env` as `AIRTABLE_ACCESS_TOKEN`

### 2.5 Create Airtable Base

1. Go to [Airtable](https://airtable.com/)
2. Create a new base called **"Upwork Leads"**
3. Create a table with these fields:
   - **Title** (Single line text)
   - **Description** (Long text)
   - **URL** (URL)
   - **Score** (Single line text)
   - **Priority** (Single select: High, Medium, Low)
   - **Reason** (Long text)
   - **Proposal** (Long text)
   - **Time Job Created** (Single line text)
   - **Applied** (Single select: Yes)
4. Copy the Base ID from the URL: `https://airtable.com/{BASE_ID}/...`
5. Paste it in `.env` as `AIRTABLE_BASE_ID`
6. Copy the Table ID (click the table dropdown → Copy table URL)
7. Paste it in `.env` as `AIRTABLE_TABLE_ID`

### 2.6 Configure Slack (Optional)

1. Go to [Slack API](https://api.slack.com/messaging/webhooks)
2. Create an incoming webhook for your workspace
3. Select a channel (e.g., #upwork-leads)
4. Copy the webhook URL
5. Paste it in `.env` as `SLACK_WEBHOOK_URL`

---

## Step 3: Start n8n with Docker

```bash
docker-compose up -d
```

Wait ~30 seconds for n8n to start, then open: [http://localhost:5678](http://localhost:5678)

**Default credentials:**
- Username: `admin`
- Password: `changeme123` (change this in `.env` before starting!)

---

## Step 4: Import Workflow

### Option A: Via n8n UI

1. Open n8n: [http://localhost:5678](http://localhost:5678)
2. Click **"Workflows"** in the sidebar
3. Click **"Import from File"**
4. Select `workflows/Upwork-Automation-Enhanced.json`
5. Click **"Import"**

### Option B: Auto-import (Docker volume mount)

The workflow is automatically available in `/workflows` directory inside the container.

---

## Step 5: Configure Workflow Credentials

### 5.1 Add OpenAI Credentials

1. In n8n, go to **Credentials** (sidebar)
2. Click **"+ Add Credential"**
3. Search for **"OpenAI"**
4. Enter your API key from `.env`
5. Click **"Save"**

### 5.2 Add Airtable Credentials

1. Click **"+ Add Credential"**
2. Search for **"Airtable Personal Access Token"**
3. Enter your token from `.env`
4. Click **"Save"**

### 5.3 Add Slack Credentials (Optional)

1. Click **"+ Add Credential"**
2. Search for **"Slack"**
3. Choose **"Webhook"**
4. Enter your webhook URL from `.env`
5. Click **"Save"**

### 5.4 Update Workflow to Use Credentials

1. Open the **"Upwork Automation"** workflow
2. Click on **"OpenAI Chat Model"** node
3. Select the OpenAI credential you just created
4. Click on **"Create a record"** (Airtable) node
5. Select the Airtable credential
6. Click on **"HTTP Request"** (Apify) node
7. Update the URL to use your Apify token:
   ```
   https://api.apify.com/v2/acts/neatrat~upwork-job-scraper/run-sync-get-dataset-items?token={{$env.APIFY_API_TOKEN}}
   ```
8. Click **"Save"** (top right)

---

## Step 6: Test Manual Execution

1. In the workflow editor, click **"Execute Workflow"** (top right)
2. Watch the nodes execute in sequence
3. Check for any errors (red nodes)
4. If successful, you should see:
   - Jobs fetched from Apify
   - AI scoring results
   - Records created in Airtable

---

## Step 7: Activate Scheduled Trigger

1. In the workflow editor, toggle the **"Active"** switch (top right)
2. The workflow will now run automatically every 8 hours
3. Check execution history in **"Executions"** (sidebar)

---

## Troubleshooting

See [troubleshooting.md](troubleshooting.md) for common issues and solutions.

---

## Next Steps

- Review the [Implementation Plan](../implementation_plan.md)
- Check [troubleshooting.md](troubleshooting.md) for common issues
- Read the [README.md](../README.md) for project overview

---

**Need help?** Check the logs:

```bash
docker-compose logs -f n8n
```
