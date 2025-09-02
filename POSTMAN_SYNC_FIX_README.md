# 🔧 Postman Sync Fix Guide

## 🚨 Issue: Collection Not Found (404 Error)

Your GitHub Actions workflow is failing because the Postman collection IDs stored in your GitHub secrets are outdated or incorrect.

**Error Details:**
```
Response Code: 404
Response Body: {"error":{"name":"instanceNotFoundError","message":"The specified item does not exist.","details":{"item":"collection","id":"f7764478-c74c-4a10-9ae6-13c6097d3802"}}}
```

## 🛠️ Solution Steps

### Step 1: Get Your Postman API Key and Workspace ID

1. **Get API Key:**
   - Go to [Postman](https://postman.com)
   - Click your profile → Settings → API Keys
   - Generate a new API key or copy existing one

2. **Get Workspace ID:**
   - Go to your Postman workspace
   - Click the gear icon (Settings) → General
   - Copy the "Workspace ID"

### Step 2: Check Existing Collections

Run this command to see what collections exist in your Postman workspace:

```bash
./debug-postman-collections.sh YOUR_POSTMAN_API_KEY YOUR_WORKSPACE_ID
```

**Example:**
```bash
./debug-postman-collections.sh PMAK-68ae4... abc123-def456-ghi789
```

### Step 3: Create Missing Collections (if needed)

If collections don't exist, create them:

```bash
./create-postman-collections.sh YOUR_POSTMAN_API_KEY YOUR_WORKSPACE_ID
```

This will create all three collections and output the collection IDs.

### Step 4: Update GitHub Secrets

1. Go to: `https://github.com/Dev-Mriganka/smartdrive-postman-collections/settings/secrets/actions`

2. **Required Secrets:**
   ```
   POSTMAN_API_KEY=your_api_key_here
   POSTMAN_WORKSPACE_ID=your_workspace_id_here
   POSTMAN_USER_COLLECTION_ID=collection_id_from_step_2_or_3
   POSTMAN_GATEWAY_COLLECTION_ID=collection_id_from_step_2_or_3
   POSTMAN_SEQUENCE_DIAGRAM_COLLECTION_ID=collection_id_from_step_2_or_3
   ```

3. **Update each secret** with the correct values

### Step 5: Re-run the Workflow

1. Go to: `https://github.com/Dev-Mriganka/smartdrive-postman-collections/actions`
2. Click the latest failed workflow
3. Click "Re-run jobs" → "Re-run all jobs"

## 📋 Quick Commands

```bash
# Check existing collections
./debug-postman-collections.sh PMAK-68ae4... your-workspace-id

# Create missing collections
./create-postman-collections.sh PMAK-68ae4... your-workspace-id

# Manual workflow trigger
echo "# Manual trigger: $(date)" >> TRIGGER_SYNC.md
git add TRIGGER_SYNC.md
git commit -m "trigger: manual sync"
git push origin main
```

## 🔍 Troubleshooting

### Common Issues:

1. **API Key Invalid:**
   ```
   Response: {"error":{"name":"authenticationError"}}
   ```
   **Fix:** Generate a new API key in Postman

2. **Workspace ID Wrong:**
   ```
   Response: {"error":{"name":"invalidWorkspaceError"}}
   ```
   **Fix:** Double-check workspace ID in Postman settings

3. **Collection Doesn't Exist:**
   ```
   Response Code: 404
   ```
   **Fix:** Run the creation script or manually create collections

### Manual Collection Creation:

If scripts don't work, create collections manually in Postman:

1. Import each JSON file from the `collections/` folder
2. Get the collection ID from the URL or API
3. Update GitHub secrets

## 🎯 Expected Outcome

After fixing the secrets, your workflow should show:

```
✅ User Service Collection updated successfully!
✅ Gateway Collection updated successfully!
✅ Sequence Diagram Tests Collection updated successfully!
✅ All Postman collections synced successfully!
```

## 📞 Need Help?

- Check the workflow logs for detailed error messages
- Verify all secrets are set correctly
- Ensure your API key has the right permissions

---

**Last Updated:** September 3, 2024
