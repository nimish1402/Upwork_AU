# Demo Video Script - Upwork Automation

**Target Duration:** 3-5 minutes  
**Format:** Screen recording with voiceover

---

## Section 1: Introduction (30 seconds)

### Visual: Title slide or project README

**Script:**
> "Hi! I'm going to show you an automated Upwork job hunting system built with n8n, Apify, and OpenAI.  
>
> The problem: Manually searching Upwork for relevant jobs is time-consuming and you often miss the best opportunities.  
>
> The solution: This workflow automatically scrapes jobs every 8 hours, scores them with AI based on your skills, and sends alerts for high-priority leads.  
>
> Let's see it in action!"

---

## Section 2: Workflow Overview (60 seconds)

### Visual: n8n workflow canvas (zoomed out to show full flow)

**Script:**
> "Here's the n8n workflow. Let me walk you through the flow:  
>
> 1. **Schedule Trigger** - Runs every 8 hours automatically  
> 2. **Fetch Jobs from Apify** - Scrapes Upwork for jobs posted in the last 6 hours  
> 3. **Normalize & Filter** - Extracts job data and removes invalid entries  
> 4. **Calculate Skill Match** - Counts how many automation keywords appear (n8n, AI, Twilio, etc.)  
> 5. **AI Scoring** - OpenAI GPT-4o evaluates each job and assigns a score, priority, and reasoning  
> 6. **Check Priority** - If the job is High priority, we send a Slack alert  
> 7. **Save to Airtable** - All scored jobs go into our lead database  
>
> The workflow includes error handling, so if any API fails, it logs to Slack and continues."

### Action: Hover over each node briefly while explaining

---

## Section 3: Live Execution (90 seconds)

### Visual: Click "Execute Workflow" button

**Script:**
> "Now let's execute this manually to see it work in real-time.  
>
> [Click Execute Workflow]  
>
> Watch the nodes light up green as they execute...  
>
> **[Node 1 - Fetch Jobs]**  
> Apify just returned 12 jobs that match our search query: 'n8n, automation, AI, workflow, Twilio'.  
>
> **[Node 2 - Normalize Fields]**  
> We're extracting the title, description, experience level, and other metadata.  
>
> **[Node 3 - Filter]**  
> This job has an empty description, so it's filtered out. We're down to 10 valid jobs.  
>
> **[Node 4 - Skill Match]**  
> This job mentions 'n8n', 'automation', and 'API' - that's a skill match score of 3 out of 13.  
>
> **[Node 5 - AI Scoring]**  
> GPT-4o is now evaluating each job. Let's look at one output...  
>
> [Click on AI Scoring node → Inspect output]  
>
> Here's the result:  
> - Score: 9/10  
> - Priority: High  
> - Reason: 'Perfect match for n8n expertise, clear scope, $500 budget, 2-day timeline. Ideal quick win.'  
>
> **[Node 6 - Check Priority]**  
> This job is High priority, so it triggers BOTH the Slack alert AND the Airtable save.  
>
> **[Node 7 - Slack Alert]**  
> Let's check Slack...  
>
> [Switch to Slack window]  
>
> There's the alert! It includes the job title, score, reason, and a button to view on Upwork. I can apply immediately.  
>
> **[Node 8 - Airtable]**  
> And now all 10 jobs are saved in Airtable..."

---

## Section 4: Airtable Results (45 seconds)

### Visual: Airtable base with job records

**Script:**
> "[Switch to Airtable]  
>
> Here's our 'Upwork Leads' base. Each job has:  
> - Title and description  
> - The AI score (1-10)  
> - Priority (High, Medium, Low)  
> - AI's reasoning  
> - Skill match count  
> - Direct URL to the job  
> - A proposal draft field where I can write my pitch  
>
> Let's filter by High priority...  
>
> [Apply filter: Priority = High]  
>
> We have 3 high-priority jobs today. I can see why the AI chose them:  
> - Job 1: 'Build n8n workflow for CRM' - 9/10, perfect skill match  
> - Job 2: 'Retell AI voice agent' - 10/10, this is exactly my specialty  
> - Job 3: 'AI chatbot integration' - 8/10, client specifically wants n8n  
>
> These are jobs I should apply to first."

---

## Section 5: Code & Documentation (30 seconds)

### Visual: VS Code or File Explorer showing project structure

**Script:**
> "[Show project files]  
>
> The entire project is version-controlled and documented:  
> - Docker Compose for easy deployment  
> - Environment variables for secure credential management  
> - Comprehensive README with setup instructions  
> - Troubleshooting guide for common issues  
> - Sample scored jobs showing AI accuracy  
>
> Everything is in the GitHub repo, ready to clone and run."

---

## Section 6: Impact & Closing (30 seconds)

### Visual: Return to n8n dashboard or summary slide

**Script:**
> "So what's the impact?  
>
> - **Time saved:** 10+ hours per week (no more manual searching)  
> - **Speed:** Instant alerts mean I can apply within minutes of a job posting  
> - **Quality:** AI filtering ensures I only see relevant opportunities  
> - **Data:** Full history in Airtable for tracking success rates  
>
> The workflow runs automatically in the background, so I never miss a lead.  
>
> This is a production-ready automation system that demonstrates:  
> - API integration (Apify, OpenAI, Airtable)  
> - AI prompt engineering for consistent scoring  
> - Error handling and logging  
> - Docker deployment  
> - Security best practices  
>
> Check out the GitHub repo for the full code and documentation. Thanks for watching!"

---

## Recording Checklist

Before recording:

- [ ] Start n8n in Docker (`docker-compose up -d`)
- [ ] Ensure all credentials are configured
- [ ] Clear previous execution history for clean demo
- [ ] Prepare Slack channel (clear old messages)
- [ ] Prepare Airtable base (clear test data or use fresh base)
- [ ] Have workflow open in n8n
- [ ] Have Slack open in another tab
- [ ] Have Airtable open in another tab
- [ ] Test run the workflow once to ensure it works

During recording:

- [ ] Close unnecessary tabs/windows
- [ ] Set browser zoom to 100% or 125% (for readability)
- [ ] Use a high-quality microphone
- [ ] Speak clearly and at a moderate pace
- [ ] Pause briefly between sections
- [ ] Show mouse cursor for clarity
- [ ] Use screen recorder with audio (OBS, Loom, or built-in)

After recording:

- [ ] Review for any errors or unclear sections
- [ ] Add captions if possible
- [ ] Export as MP4 (H.264 codec recommended)
- [ ] Keep file size under 100MB (compress if needed)
- [ ] Place in `videos/demo.mp4`

---

## Technical Setup Notes

**Screen Recording Tools:**
- **Windows:** OBS Studio, Xbox Game Bar, or Loom
- **Mac:** QuickTime, ScreenFlow, or Loom
- **Online:** Loom (easiest, cloud-hosted)

**Recommended Settings:**
- Resolution: 1920x1080 (Full HD)
- Frame rate: 30 FPS
- Audio: 44.1 kHz, stereo
- Format: MP4 (H.264 video, AAC audio)

**Editing (Optional):**
- Trim intro/outro silence
- Add title card at beginning
- Add GitHub repo URL at end
- Speed up slow sections (e.g., API calls) to 1.5x

---

## Backup Script (If Anything Goes Wrong)

If live execution fails during recording, you can use this backup approach:

1. **Pre-record the execution** and show it as a "previous run"
2. **Navigate to Executions** tab in n8n
3. **Click on a successful execution** to show the results
4. **Walk through each node's output** as if it just ran

This is less impressive than live execution but still demonstrates the workflow.

---

## Tips for a Great Demo

✅ **Practice the script** 2-3 times before recording  
✅ **Speak naturally** - don't read word-for-word  
✅ **Smile** - it comes through in your voice!  
✅ **Use transitions** - "Now let's check Slack..." instead of awkward silence  
✅ **Highlight key values** - "This saved me 10 hours per week"  
✅ **Keep it concise** - Aim for 3-4 minutes, max 5 minutes  
✅ **End with a call-to-action** - "Check out the GitHub repo"

Good luck! 🎬
