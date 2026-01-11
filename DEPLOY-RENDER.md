# Deploy to Render.com - Step by Step Guide

## Prerequisites

1. ✅ GitHub repository: https://github.com/nimish1402/Upwork_AU
2. ✅ Render.com account (free tier available)
3. ✅ API credentials ready (Gemini, Airtable, Slack)

---

## Step 1: Create Render Account

1. Go to [render.com](https://render.com/)
2. Click **"Get Started"**
3. Sign up with GitHub (recommended for easy deployment)
4. Authorize Render to access your repositories

---

## Step 2: Create New Web Service

1. From Render Dashboard, click **"New +"**
2. Select **"Web Service"**
3. Connect to your GitHub repository:
   - Repository: `nimish1402/Upwork_AU`
4. Click **"Connect"**

---

## Step 3: Configure Service Settings

### Basic Settings:
- **Name:** `upwork-automation` (or your preferred name)
- **Region:** Choose closest to you (e.g., Singapore, Oregon)
- **Branch:** `main`
- **Root Directory:** Leave blank (or `.`)

### Build & Deploy:
- **Runtime:** `Docker`
- **Dockerfile Path:** `Dockerfile` (we'll create this)

### Instance Type:
- **Free tier:** Select "Free" ($0/month)
  - ⚠️ Spins down after 15 min of inactivity
  - Suitable for testing and demo
- **Starter:** $7/month
  - Always on
  - Recommended for production

---

## Step 4: Add Environment Variables

Click **"Advanced"** → **"Add Environment Variable"**

Add these variables:

| Key | Value | Notes |
|-----|-------|-------|
| `N8N_BASIC_AUTH_ACTIVE` | `true` | Enable authentication |
| `N8N_BASIC_AUTH_USER` | `admin` | Username for n8n |
| `N8N_BASIC_AUTH_PASSWORD` | `your-secure-password` | Change this! |
| `N8N_ENCRYPTION_KEY` | `your-random-encryption-key` | Generate a random string |
| `WEBHOOK_URL` | `https://upwork-automation.onrender.com/` | Your Render URL |
| `N8N_BLOCK_ENV_ACCESS_IN_NODE` | `false` | Allow env vars in workflow |
| `GOOGLE_GEMINI_API_KEY` | `your-gemini-key` | From `.env` file |
| `AIRTABLE_ACCESS_TOKEN` | `your-airtable-token` | From `.env` file |
| `AIRTABLE_BASE_ID` | `your-base-id` | From `.env` file |
| `AIRTABLE_TABLE_ID` | `your-table-id` | From `.env` file |
| `SLACK_WEBHOOK_URL` | `your-slack-webhook` | Optional |
| `UPWORK_SEARCH_QUERY` | `n8n,automation,AI,workflow` | Search keywords |
| `JOB_MAX_AGE_HOURS` | `6` | Job age filter |

**To generate encryption key:**
```bash
openssl rand -hex 32
```

---

## Step 5: Deploy

1. Click **"Create Web Service"**
2. Render will:
   - Clone your repository
   - Build the Docker image
   - Deploy n8n
   - Assign a URL (e.g., `https://upwork-automation.onrender.com`)

**Initial deployment takes 5-10 minutes**

---

## Step 6: Access Your n8n Instance

1. Wait for deployment to complete
2. Open the Render URL: `https://your-app-name.onrender.com`
3. Login with:
   - Username: `admin` (or what you set)
   - Password: Your password from env vars

---

## Step 7: Import Workflow

1. In n8n, go to **Workflows**
2. Click **"Add workflow"** → **"Import from File"**
3. Upload: `workflows/Upwork-Automation-Enhanced.json`
4. Configure credentials:
   - Google Gemini API
   - Airtable Personal Access Token
   - Slack Webhook (optional)

---

## Step 8: Test & Activate

1. Replace "Fetch Jobs from Apify" with **Code node** (mock data)
2. Paste mock data from `mock-jobs.json`
3. Click **"Execute Workflow"**
4. Verify results in Airtable
5. **Activate** the workflow (toggle switch)

---

## Render Configuration Files

These files need to be added to your repository:

### 1. `Dockerfile`
Already covered by docker-compose.yml, but Render needs a standalone Dockerfile.

### 2. `render.yaml` (Optional - Infrastructure as Code)
Defines your entire deployment configuration.

---

## Important Notes

### Free Tier Limitations:
- ⚠️ **Spins down after 15 min inactivity**
- Scheduled workflows may not work reliably
- Cold start takes 30-60 seconds

### Solutions:
1. **Upgrade to Starter ($7/mo)** - Always on
2. **Use cron-job.org** to ping your Render URL every 14 minutes
3. **For demo only:** Manually trigger workflow when needed

---

## Troubleshooting

### "Application failed to respond"
- Check Render logs
- Ensure port 5678 is exposed
- Verify environment variables are set

### "Webhook URL not working"
- Use the full Render URL
- Example: `https://upwork-automation.onrender.com/`

### "Workflow not executing on schedule"
- Free tier may spin down
- Upgrade to Starter plan or use external cron

---

## Custom Domain (Optional)

1. In Render Dashboard → Your Service
2. Go to **"Settings"** → **"Custom Domains"**
3. Add your domain
4. Update DNS records as shown by Render

---

## Cost Estimate

| Plan | Cost | Features |
|------|------|----------|
| **Free** | $0/month | Spins down after 15 min |
| **Starter** | $7/month | Always on, 512MB RAM |
| **Standard** | $25/month | 2GB RAM, better performance |

**Recommendation:** 
- **Demo/Testing:** Free tier
- **Production:** Starter ($7/mo)

---

## Next Steps

1. ✅ Create Dockerfile
2. ✅ Add render.yaml
3. ✅ Push to GitHub
4. ✅ Deploy on Render
5. ✅ Import workflow
6. ✅ Test execution
7. ✅ Record demo video showing live deployment!

---

**Your deployed n8n will be live at:**
`https://your-service-name.onrender.com`

This can be included in your assignment submission as a bonus! 🚀
