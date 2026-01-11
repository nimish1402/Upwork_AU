# Next Steps - Quick Reference

## Immediately After This

### 1. Set Up API Credentials (30-45 min)

#### Apify
- [ ] Sign up at https://apify.com/
- [ ] Navigate to Settings → Integrations
- [ ] Copy API token
- [ ] Add to `.env` as `APIFY_API_TOKEN`

#### Google Gemini
- [ ] Go to https://aistudio.google.com/app/apikey
- [ ] Sign in with your Google account
- [ ] Click "Create API Key"
- [ ] Copy the API key
- [ ] Add to `.env` as `GOOGLE_GEMINI_API_KEY`
- [ ] (Free tier: 60 requests/min, no payment needed!)

#### Airtable
- [ ] Sign up at https://airtable.com/
- [ ] Create new base called "Upwork Leads"
- [ ] Add fields:
  - Title (Single line text)
  - Description (Long text)
  - URL (URL)
  - Score (Single line text)
  - Priority (Single select: High, Medium, Low)
  - Reason (Long text)
  - Proposal (Long text)
  - Time Job Created (Single line text)
  - Skill Match (Number)
  - Applied (Single select: Yes)
- [ ] Go to Account → Developer hub → Create token
- [ ] Grant scopes: data.records:read, data.records:write, schema.bases:read
- [ ] Copy token to `.env` as `AIRTABLE_ACCESS_TOKEN`
- [ ] Copy Base ID from URL to `.env` as `AIRTABLE_BASE_ID`
- [ ] Copy Table ID to `.env` as `AIRTABLE_TABLE_ID`

#### Slack (Optional but Recommended)
- [ ] Go to https://api.slack.com/messaging/webhooks
- [ ] Create incoming webhook
- [ ] Choose channel (#upwork-leads)
- [ ] Copy webhook URL to `.env` as `SLACK_WEBHOOK_URL`

---

### 2. Test the Workflow (15-20 min)

```bash
# Make sure you're in the project directory
cd d:\projects\Resume\Edxso

# Create .env from template
cp .env.example .env

# Edit .env with your credentials (use notepad or VS Code)
notepad .env

# Start n8n
docker-compose up -d

# Check if it's running
docker ps

# Wait 30 seconds, then open
# http://localhost:5678
```

**In n8n:**
1. Login (admin / changeme123)
2. Import: workflows/Upwork-Automation-Enhanced.json
3. Configure credentials:
   - OpenAI API
   - Airtable Personal Access Token
   - Slack Webhook (if using)
4. Click "Execute Workflow"
5. Watch nodes execute
6. Check Airtable for results
7. If High-priority job, check Slack

---

### 3. Record Demo Video (30-45 min)

Follow [docs/demo-script.md](file:///d:/projects/Resume/Edxso/docs/demo-script.md)

**Quick checklist:**
- [ ] Close unnecessary browser tabs
- [ ] Clear n8n execution history for clean demo
- [ ] Open n8n, Slack, and Airtable in separate tabs
- [ ] Start screen recorder (OBS/Loom/QuickTime)
- [ ] Record narration while executing workflow
- [ ] Show: scraping → AI scoring → Slack alert → Airtable
- [ ] Keep it under 5 minutes
- [ ] Save as videos/demo.mp4

**Upload options:**
- YouTube (unlisted) - then link in README
- Loom - then embed link
- GitHub Releases - for files > 100MB

---

### 4. Push to GitHub (5 min)

```bash
# Create new GitHub repo (do this on github.com first)
# Then:

git remote add origin https://github.com/YOUR-USERNAME/upwork-automation.git
git branch -M main
git push -u origin main
```

**Update README with:**
- Your GitHub username in clone URL
- Demo video link (YouTube/Loom)
- Your contact email

---

### 5. Final Submission

**Include in your submission:**
1. ✅ GitHub repository URL
2. ✅ Demo video link (if not in repo)
3. ✅ Brief note: "See docs/report.md for detailed report"

---

## If You Run Into Issues

### Docker not starting?
```bash
# Check Docker Desktop is running
# Then restart:
docker-compose down
docker-compose up -d
```

### n8n won't load?
```bash
# Check logs:
docker-compose logs -f n8n

# Common fix: restart
docker-compose restart n8n
```

### API errors?
- Check credentials in .env
- Ensure you have billing set up (OpenAI)
- Check API quotas in each platform

### Need help?
- See: [docs/troubleshooting.md](file:///d:/projects/Resume/Edxso/docs/troubleshooting.md)

---

## Estimated Timeline

| Task | Time |
|------|------|
| Get API credentials | 30-45 min |
| Set up .env | 5 min |
| Start Docker & test | 15-20 min |
| Record demo video | 30-45 min |
| Push to GitHub | 5 min |
| **Total** | **~2 hours** |

---

## Success Checklist

Before submitting, verify:

- [ ] All API credentials configured
- [ ] Workflow executes without errors
- [ ] Airtable has records from test run
- [ ] Demo video recorded and uploaded
- [ ] GitHub repository is public
- [ ] README has correct clone URL
- [ ] No .env file in GitHub (check!)
- [ ] docs/report.md is complete

---

## You're Almost Done! 🎉

Everything is built and documented. You just need to:
1. Get API keys (30-45 min)
2. Test it works (15-20 min)  
3. Record a video (30-45 min)
4. Push to GitHub (5 min)

**Total time to finish: ~2 hours**

Good luck! 🚀
