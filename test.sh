#!/bin/bash
export TYK_SECRET="foo"
export REDIS_PASS=$(gcloud secrets versions access latest --secret="redis-pass")
export NAMESPACE="tyk"
export TYK_STATIC_IP=localhost:8080
# export TYK_STATIC_IP=$(gcloud compute addresses describe tyk-static-ip --global --format='get(address)')

# curl --location --request POST "http://localhost:8080/tyk/policies" \
# --header "x-tyk-authorization: 352d20ee67be67f6340b4c0605b044b7" \
# --header 'Content-Type: application/json' \
# --data '{
#   "name": "new policy",
#   "quota_max": 60,
#   "quota_renewal_rate": 60,
#   "allowance": 100,
#   "rate": 100,
#   "per": 5
# }'

curl -X GET localhost:8080/tyk/reload \
  --header "X-Tyk-Authorization: 352d20ee67be67f6340b4c0605b044b7"


# curl --location --request GET http://localhost:8080/tyk/policies \
#   --header "x-tyk-authorization: 352d20ee67be67f6340b4c0605b044b7"

# curl --location --request DELETE "http://$TYK_STATIC_IP/tyk/keys/eyJvcmciOiIiLCJpZCI6ImIyZjcxYTA1NWEzMjQ0NjNhNjQ1Y2EzYzYzZGJiNTRjIiwiaCI6Im11cm11cjEyOCJ9" \
# --header "x-tyk-authorization: $TYK_SECRET" \a