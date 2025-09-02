#!/bin/bash

# Debug script to get Postman collection IDs and update GitHub secrets
# Usage: ./debug-postman-collections.sh YOUR_POSTMAN_API_KEY YOUR_WORKSPACE_ID

set -e

if [ $# -lt 2 ]; then
    echo "❌ Usage: $0 <POSTMAN_API_KEY> <POSTMAN_WORKSPACE_ID>"
    echo ""
    echo "Example:"
    echo "  $0 PMAK-68ae4... your-workspace-id"
    echo ""
    echo "Find your Workspace ID in Postman: Workspace Settings → General → Workspace ID"
    exit 1
fi

POSTMAN_API_KEY="$1"
WORKSPACE_ID="$2"

echo "🔍 Getting collections from Postman workspace..."
echo "API Key: ${POSTMAN_API_KEY:0:10}..."
echo "Workspace ID: $WORKSPACE_ID"
echo ""

# Get collections from workspace
response=$(curl -s -H "X-API-Key: $POSTMAN_API_KEY" \
    "https://api.getpostman.com/collections?workspace=$WORKSPACE_ID")

echo "📋 Collections in your workspace:"
echo "$response" | jq -r '.collections[] | "• \(.name) (ID: \(.id))"' 2>/dev/null || echo "❌ Failed to parse response"

echo ""
echo "🔧 Required GitHub Secrets:"
echo ""

# Extract collection IDs for our collections
user_service_id=$(echo "$response" | jq -r '.collections[] | select(.name | contains("User Service")) | .id' 2>/dev/null)
gateway_id=$(echo "$response" | jq -r '.collections[] | select(.name | contains("Gateway")) | .id' 2>/dev/null)
sequence_id=$(echo "$response" | jq -r '.collections[] | select(.name | contains("Sequence Diagram")) | .id' 2>/dev/null)

if [ ! -z "$user_service_id" ]; then
    echo "POSTMAN_USER_COLLECTION_ID=$user_service_id"
else
    echo "# POSTMAN_USER_COLLECTION_ID= (not found - needs to be created)"
fi

if [ ! -z "$gateway_id" ]; then
    echo "POSTMAN_GATEWAY_COLLECTION_ID=$gateway_id"
else
    echo "# POSTMAN_GATEWAY_COLLECTION_ID= (not found - needs to be created)"
fi

if [ ! -z "$sequence_id" ]; then
    echo "POSTMAN_SEQUENCE_DIAGRAM_COLLECTION_ID=$sequence_id"
else
    echo "# POSTMAN_SEQUENCE_DIAGRAM_COLLECTION_ID= (not found - needs to be created)"
fi

echo ""
echo "📝 Instructions:"
echo "1. Go to: https://github.com/Dev-Mriganka/smartdrive-postman-collections/settings/secrets/actions"
echo "2. Update the secrets above with the correct collection IDs"
echo "3. If collections don't exist, create them in Postman first"
echo "4. Re-run the workflow after updating secrets"
