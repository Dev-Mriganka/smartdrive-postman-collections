# Postman Sync Trigger

This file is used to trigger the Postman collection sync workflow.

## How to trigger sync:

1. **Edit this file** - Add a timestamp or change any content
2. **Commit and push** - The workflow will automatically run
3. **Check results** - View the workflow in GitHub Actions

## Last sync trigger:

- Date: 2024-09-03
- Time: Updated workflow for sequence diagram tests
- Status: Ready for production testing
- Collections: User Service, Gateway, Sequence Diagram Tests

## Usage:

```bash
# To trigger sync manually:
echo "# Last updated: $(date)" >> TRIGGER_SYNC.md
git add TRIGGER_SYNC.md
git commit -m "trigger: manual sync trigger"
git push origin main
```

## Workflow triggers:

- Changes to `collections/` folder
- Changes to `environments/` folder
- Changes to this trigger file
- Manual trigger via GitHub UI
