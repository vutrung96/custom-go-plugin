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

# curl -X GET localhost:8080/tyk/reload \
#   --header "X-Tyk-Authorization: 352d20ee67be67f6340b4c0605b044b7"

# curl --location --request GET http://localhost:8080/tyk/apis/oas \
#   --header "x-tyk-authorization: 352d20ee67be67f6340b4c0605b044b7"


# curl --location --request GET http://localhost:8080/tyk/policies \
#   --header "x-tyk-authorization: 352d20ee67be67f6340b4c0605b044b7"

# curl --location --request DELETE "http://$TYK_STATIC_IP/tyk/keys/eyJvcmciOiIiLCJpZCI6ImIyZjcxYTA1NWEzMjQ0NjNhNjQ1Y2EzYzYzZGJiNTRjIiwiaCI6Im11cm11cjEyOCJ9" \
# --header "x-tyk-authorization: $TYK_SECRET" \a

# curl localhost:8080/httpbin/get \
#   --header "api_key: abc"

# curl -X PUT localhost:8080/tyk/apis/oas/0b30d18d1b8548bb458af4d0e1089db9 \
#   --header "X-Tyk-Authorization: 352d20ee67be67f6340b4c0605b044b7" \
#   --header "Content-Type: application/json" \
#   --data "@tyk/scripts/oas.json"

# curl -X GET localhost:8080/tyk/reload \
#   --header "X-Tyk-Authorization: 352d20ee67be67f6340b4c0605b044b7"

# curl localhost:8080/json/httpbin/get \
#   --header "api_key: abc"

curl -X POST localhost:8080/tyk/keys/abc \
  --header "x-tyk-authorization: 352d20ee67be67f6340b4c0605b044b7" \
  --data '{
    "quota_max": 60,
    "quota_renews": 1406121006,
    "quota_renewal_rate": 60,
    "allowance": 100,
    "rate": 100,
    "per": 5,
    "org_id": "",
    "access_rights": {
     "0b30d18d1b8548bb458af4d0e1089db9": {
        "allowed_urls" : [
          {
            "url": "/get",
            "methods": ["GET"]
          }
        ]
     }
    }
  }'

# curl -X GET localhost:8080/tyk/keys/eyJvcmciOiI1M2FjMDc3NzdjYmI4YzJkNTMwMDAwMDIiLCJpZCI6ImFiYyIsImgiOiJtdXJtdXI2NCJ9 \
#   --header "x-tyk-authorization: 352d20ee67be67f6340b4c0605b044b7" 
  # --data '{
  #   "quota_max": 60,
  #   "quota_renews": 1406121006,
  #   "quota_renewal_rate": 60,
  #   "allowance": 100,
  #   "rate": 100,
  #   "per": 5,
  #   "org_id": "53ac07777cbb8c2d53000002",
  #   "access_rights": {
  #    "0b30d18d1b8548bb458af4d0e1089db9": {
  #       "allowed_urls" : [
  #         {
  #           "url": "/httpbin/get",
  #           "methods": ["GET"]
  #         }
  #       ]
  #    }
  #   }
  # }'

curl -X PUT localhost:8080/tyk/apis/oas/0b30d18d1b8548bb458af4d0e1089db9 \
  --header "X-Tyk-Authorization: 352d20ee67be67f6340b4c0605b044b7" \
  --header "Content-Type: application/json" \
  --data "@tyk/scripts/oas.json"

curl -X GET localhost:8080/tyk/reload \
  --header "X-Tyk-Authorization: 352d20ee67be67f6340b4c0605b044b7" 


curl localhost:8080/json/get \
  -H "api_key: abac"
  # -H "Authorization: eyJvcmciOiI1M2FjMDc3NzdjYmI4YzJkNTMwMDAwMDIiLCJpZCI6ImFiYyIsImgiOiJtdXJtdXI2NCJ9" \
