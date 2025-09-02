#!/bin/bash

# Script to create Postman collections if they don't exist
# Usage: ./create-postman-collections.sh YOUR_POSTMAN_API_KEY YOUR_WORKSPACE_ID

set -e

if [ $# -lt 2 ]; then
    echo "❌ Usage: $0 <POSTMAN_API_KEY> <POSTMAN_WORKSPACE_ID>"
    echo ""
    echo "Example:"
    echo "  $0 PMAK-68ae4... your-workspace-id"
    exit 1
fi

POSTMAN_API_KEY="$1"
WORKSPACE_ID="$2"

echo "🔧 Creating missing Postman collections..."
echo "API Key: ${POSTMAN_API_KEY:0:10}..."
echo "Workspace ID: $WORKSPACE_ID"
echo ""

# Function to create a collection
create_collection() {
    local collection_name="$1"
    local collection_file="$2"

    echo "📝 Creating collection: $collection_name"

    if [ ! -f "$collection_file" ]; then
        echo "❌ Collection file not found: $collection_file"
        return 1
    fi

    # Create the collection in Postman
    response=$(curl -s -w "%{http_code}" -X POST \
        -H "X-API-Key: $POSTMAN_API_KEY" \
        -H "Content-Type: application/json" \
        -d @"$collection_file" \
        "https://api.getpostman.com/collections")

    http_code="${response: -3}"
    body="${response%???}"

    if [ "$http_code" = "200" ]; then
        collection_id=$(echo "$body" | jq -r '.collection.id' 2>/dev/null)
        echo "✅ Created collection: $collection_name (ID: $collection_id)"
        echo "POSTMAN_${collection_name//[^a-zA-Z0-9]/_}_COLLECTION_ID=$collection_id"
        return 0
    else
        echo "❌ Failed to create collection: $collection_name"
        echo "Response: $body"
        return 1
    fi
}

# Create collections
echo "Creating collections..."

# User Service Collection
if create_collection "USER_SERVICE" "collections/SmartDrive-User-Service-Collection.json"; then
    echo "✅ User Service collection created successfully"
else
    echo "❌ Failed to create User Service collection"
fi

# Gateway Collection
if create_collection "GATEWAY" "collections/SmartDrive-Gateway-Complete-Collection.json"; then
    echo "✅ Gateway collection created successfully"
else
    echo "❌ Failed to create Gateway collection"
fi

# Sequence Diagram Collection
if create_collection "SEQUENCE_DIAGRAM" "collections/SmartDrive-Sequence-Diagram-Tests.json"; then
    echo "✅ Sequence Diagram collection created successfully"
else
    echo "❌ Failed to create Sequence Diagram collection"
fi

echo ""
echo "🎉 Collection creation complete!"
echo ""
echo "📋 Next steps:"
echo "1. Copy the POSTMAN_*_COLLECTION_ID values above"
echo "2. Add them as secrets in GitHub: https://github.com/Dev-Mriganka/smartdrive-postman-collections/settings/secrets/actions"
echo "3. Re-run the workflow"
