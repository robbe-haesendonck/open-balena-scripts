#!/bin/bash

API_URL="api.example.org"

USERNAME="example@example.org"
PASSWORD="VerySecurePassword"

session_token=$(curl -s -X POST 'https://'$API_URL'/login_' \
-H 'content-type: application/json' \
-d '{"username":"'$USERNAME'","password":"'$PASSWORD'"}')

echo "Session Token: $session_token"

echo "Getting all API keys:"
api_keys=$(curl -X GET \
"https://$API_URL/v6/api_key" \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $session_token" | jq)

echo "$api_keys"

read -p "ID of the key you want to revoke:" key_id

revoke_response=$(curl -X DELETE \
"https://$API_URL/v6/api_key($key_id)" \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $session_token")

# If this is empty; it's basically succeeded
echo "$revoke_response"