# Troubleshooting Guide

## Common Issues and Solutions

### Docker Issues

#### Problem: "Docker daemon is not running"

**Solution:**
1. Start Docker Desktop
2. Wait for it to fully initialize
3. Run `docker-compose up -d` again

#### Problem: "Port 5678 is already in use"

**Solution:**
```bash
# Stop the conflicting service
docker ps  # Find container using port 5678
docker stop <container-id>

# Or change the port in docker-compose.yml
ports:
  - "5679:5678"  # Access n8n at localhost:5679
```

---

### n8n Startup Issues

#### Problem: "Cannot access n8n at localhost:5678"

**Solution:**
1. Check if container is running:
   ```bash
   docker ps
   ```
2. Check logs for errors:
   ```bash
   docker-compose logs -f n8n
   ```
3. Restart the container:
   ```bash
   docker-compose restart n8n
   ```

#### Problem: "Basic auth not working"

**Solution:**
1. Check `.env` file has correct credentials
2. Restart n8n:
   ```bash
   docker-compose down
   docker-compose up -d
   ```
3. Clear browser cache and try again

---

### API Credential Issues

#### Problem: "Apify returns 401 Unauthorized"

**Solution:**
1. Verify token in `.env` is correct
2. Check token hasn't expired in [Apify Console](https://console.apify.com/account/integrations)
3. Update the token in the HTTP Request node URL
4. Save workflow and test again

#### Problem: "OpenAI returns 429 Rate Limit Error"

**Solution:**
1. You've hit the rate limit or exceeded quota
2. Check usage at [OpenAI Usage](https://platform.openai.com/usage)
3. Add billing method if needed
4. Wait a few minutes and try again
5. Consider adding retry logic to the workflow

#### Problem: "Airtable returns 403 Forbidden"

**Solution:**
1. Verify token has correct scopes:
   - `data.records:read`
   - `data.records:write`
   - `schema.bases:read`
2. Ensure token has access to the specific base
3. Regenerate token if necessary
4. Update in n8n credentials

---

### Workflow Execution Issues

#### Problem: "Apify node returns empty array"

**Possible causes:**
1. No jobs posted in last 6 hours matching the query
2. Wrong search query
3. Apify API issue

**Solution:**
1. Test with broader query: `"automation"` instead of `"n8n"`
2. Increase `maxJobAge` to 24 hours temporarily
3. Check Apify execution logs in console

#### Problem: "AI scoring returns inconsistent formats"

**Solution:**
1. Review the prompt in "Analyse Job" node
2. Ensure Structured Output Parser is connected
3. Test with a single job first
4. Check OpenAI model version is `chatgpt-4o-latest`

#### Problem: "Airtable creates duplicate records"

**Solution:**
1. Add a filter to check for existing records:
   ```javascript
   // In a Code node before Airtable
   const jobUrl = $json.url;
   const existingRecords = /* query Airtable for URL */;
   if (existingRecords.length > 0) {
     return null; // Skip this item
   }
   return $json;
   ```
2. Or use Airtable's "Update" operation with URL as matching field

#### Problem: "Workflow stops after first error"

**Solution:**
1. Enable "Continue On Fail" for nodes:
   - Click on node
   - Settings tab → Continue On Fail
2. Add Error Trigger node for logging
3. Use Try/Catch pattern with IF nodes

---

### Scheduled Trigger Issues

#### Problem: "Workflow not running automatically"

**Solution:**
1. Check if workflow is **Activated** (toggle switch in top right)
2. Verify Schedule Trigger is configured correctly:
   ```json
   {
     "rule": {
       "interval": [
         {
           "field": "hours",
           "hoursInterval": 8
         }
       ]
     }
   }
   ```
3. Check execution history to see if it ran but failed

#### Problem: "Workflow runs but no jobs are processed"

**Solution:**
1. Check Apify API response manually
2. Verify job age filter (might be too restrictive)
3. Check if Upwork has jobs matching your query
4. Review execution logs for errors

---

### Data Issues

#### Problem: "AI scores are all 10/10 or all 1/10"

**Possible causes:**
- Prompt is too lenient/strict
- Model hallucination
- Training data bias

**Solution:**
1. Review and refine the prompt
2. Add specific examples in prompt
3. Test with diverse job types
4. Adjust scoring criteria

#### Problem: "Job descriptions are truncated"

**Solution:**
1. Check Apify scraper limitations
2. Increase field limits in Airtable
3. Use Long Text field type in Airtable

---

### Performance Issues

#### Problem: "Workflow takes too long to execute"

**Solution:**
1. Reduce number of jobs processed per run
2. Add pre-filtering before AI scoring
3. Use parallel processing where possible
4. Optimize AI prompt (shorter = faster)

#### Problem: "High OpenAI costs"

**Solution:**
1. Implement pre-filtering (budget, experience level)
2. Use keyword matching before AI scoring
3. Reduce maxJobAge to 6 hours
4. Set a budget limit in OpenAI dashboard

---

### Environment Variable Issues

#### Problem: ".env file not loading"

**Solution:**
1. Check `.env` is in the same directory as `docker-compose.yml`
2. Rebuild the container:
   ```bash
   docker-compose down
   docker-compose up -d
   ```
3. Verify syntax (no spaces around `=`)
   ```bash
   CORRECT: API_KEY=abc123
   WRONG: API_KEY = abc123
   ```

---

## Getting Help

If you're still stuck:

1. **Check n8n logs:**
   ```bash
   docker-compose logs -f n8n
   ```

2. **Check workflow execution logs:**
   - Open n8n UI
   - Go to "Executions" in sidebar
   - Click on failed execution
   - Review error messages

3. **Test individual nodes:**
   - Click on a node
   - Click "Execute Node" (in top bar)
   - Inspect input/output data

4. **Community Resources:**
   - [n8n Community Forum](https://community.n8n.io/)
   - [n8n Documentation](https://docs.n8n.io/)
   - [Apify Docs](https://docs.apify.com/)
   - [OpenAI Docs](https://platform.openai.com/docs/)
   - [Airtable API Docs](https://airtable.com/developers/web/api/introduction)

---

## Debug Checklist

Before asking for help, verify:

- [ ] Docker is running
- [ ] n8n container is running (`docker ps`)
- [ ] All credentials are configured correctly
- [ ] `.env` file has real values (not placeholders)
- [ ] Workflow is saved after changes
- [ ] API quotas/limits are not exceeded
- [ ] Node connections are correct
- [ ] "Continue On Fail" is enabled where needed
- [ ] Execution logs show specific error messages
