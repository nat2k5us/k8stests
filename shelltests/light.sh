#!/usr/local/bin/bash

function helpLight() {
  echo "need parms ..."
  printf "Usage : \
   \n light.sh [command] [symbol] [filter] [account] \
   \n Commands: \
    \n\tping-local - curl calls to ping, version, healthz and healthy \
    \n\ttoken - gets token \
    \n\taccounts - gets account for user "
}

if [ "$1" = "" ]; then
  # printf "\033[1;31mError: No parameters specified, usage examples ...\033[0m\n"
  helpLight
  exit 0
elif [ "$1" = "ping-local" ]; then
  curl -k http://localhost:8001/.version | jq .
  curl -k http://localhost:8001/us-eng/ping | jq .
  curl -k http://localhost:8002/healthy | jq .
  curl -k http://localhost:8002/healthz | jq .
  exit 0
elif [ "$1" = "help" ]; then
  helpLight
  exit 0
fi
echo "OK"

read -n 1 -p "Please choose Port-(F)orward, (E)ngineering, (Q)A, (S)taging, (l)ocalhost or (P)rod? " ans

case $ans in
q | Q)
  export Environment=qa
  ;;
s | S)
  export Environment=stg
  ;;
e | E)
  export Environment=eng
  ;;
f | F)
  export Environment=pf
  ;;
l | L)
  export Environment=localhost
  ;;
p | P)
  export Environment=prod
  ;;
*)
  exit
  ;;
esac

echo "using Environment $Environment"

username="nbontha"
password="testingnat9"
export username=nbontha
export password=testingnat9
export prodpassword=tradeprod123crypto$
export produsername=tciprodtest
lightspeed="bW9iaWxlOnRyYWRlMTIzc3RhdGlvbg=="

curlRequestEndpoint() {
  ENDPOINT=$1
  SYM=$2
  TOKEN=$3
  if [ "$2" = "" ]; then
    FULLURL=$BASEURL/$ENDPOINT
  else
    FULLURL=$BASEURL/$ENDPOINT/"$2"
  fi
  # echo "full Curl => curl -k --url $FULLURL -H X-TS-Auth-User-ID: $username -H Authorization: Bearer ${TOKEN} | jq ."
  echo "fullurl => $FULLURL"
  curl -k --url $FULLURL \
    -H "X-TS-Auth-User-ID: $username" \
    -H "Authorization: Bearer ${TOKEN}" | jq .
}

function getToken() {
  NameIn=$1
  PasswordIn=$2
  curl --request POST \
    -v -k \
    --url 'https://signin.tradestation.com/oauth/token' \
    --header 'content-type: application/x-www-form-urlencoded' \
    --data grant_type="http://auth0.com/oauth/grant-type/password-realm" \
    --data username=$NameIn \
    --data password=$PasswordIn \
    --data audience="https://api.tradestation.com" \
    --data scope=oopenid+profile+MarketData+ReadAccount+Trade+Matrix+Crypto \
    --data client_id="Sg8Fa1mdIC7IAEYxbHw6wZn4gzjLccl7" \
    --data client_secret="DPVVY_m0fnwNQT3dxj-IMMG8O5MaU25ZLQgeZmhuBteywovhML7UERHcS-3zPI2G" \
    --data realm=auth0-api-connection |
    jq -r .access_token
}

function getTokenStg() {
# echo "getting token Stg"
    # https://signin-stg.tradestation.io/oauth/token New 4/20/2020
    # https://tradestation-stg.tslogin-dev.auth0.com/oauth/token << 
    # 'https://login-stg.tradestation.io/oauth/token' << Old
    NameIn=$1
    PasswordIn=$2
    curl --request POST \
        -k \
        --url 'https://signin-stg.tradestation.io/oauth/token' \
        --header 'content-type: application/x-www-form-urlencoded' \
        --data grant_type="http://auth0.com/oauth/grant-type/password-realm" \
        --data username=$NameIn \
        --data password=$PasswordIn \
        --data audience="https://api.tradestation.io" \
        --data scope=openid+profile+MarketData+ReadAccount+Trade+Matrix+Crypto \
        --data client_id="kZv8C65sif5KwWfIde0PMI0jcnK0jx8U" \
        --data client_secret="WNGWhE-v_MotIEOHzoVOFF_iSJ4j3GP8O8dgJQcbMeoOpnT12af-l8aOcH_CbKh_" \
        --data realm=auth0-api-connection |
        jq -r .access_token

}

function getAccounts() {
  export token=$(getToken $produsername $prodpassword)
  curl -v -k --http1.1 --url https://api.tradestation.com/v3/brokerage/accounts \
    -H "X-TS-Auth-User-ID: $username" \
    -H "X-Nitro-Authorization: $NitroAuthorization" \
    -H "Authorization: Bearer ${token}" | jq -r '.Accounts[].AccountID'
}

echo "Making calls using token..."
if [ "$Environment" = "" ]; then
  BASEURL="http://127.0.0.1:8001"
  export TOKEN=$(getToken $username $password)
elif [ "$Environment" = "localhost" ]; then
  export TOKEN=$(getToken $username $password)

  BASEURL="http://localhost:8001"
  username=$username
  password=$password
  ACCOUNTS=736329107,736329108,736329109
elif [ "$Environment" = "qa" ]; then
  export TOKEN=$(getTokenStg 'iosapp1' 'poweruser')
  echo $TOKEN
  # export TOKEN=$(getTokenQA $username $password)
  export ACCOUNTS=
  username=$username
  password=$password
  BASEURL="https://api.tradestation.io"
elif [ "$Environment" = "eng" ]; then
  export TOKEN=$(getToken $usernameeng $passwordeng)
  export ACCOUNTS=31001905
  export CRYPTOACCOUNT=31000261
  # username=jsamuel
  NitroAuthorization=test
  username=$usernameeng
  password=$passwordeng
  BASEURL="https://eng-nitro.tp-eng-usva-2.nite.tradestation.io"
elif [ "$Environment" = "stg" ]; then
  export TOKEN=$(getToken $usernamestg $passwordstg)
  export ACCOUNTS="$marginacctstg,$futuresacctstg,$cashacctstg"
  CRYPTOACCOUNT=$cryptoacctstg
  username=$usernamestg
  password=$passwordstg
  BASEURL="https://api.stg.tradestation.io/v3"
elif [ "$Environment" = "prod" ]; then
  echo "using prod"
  export TOKEN=$(getToken)
  export ACCOUNTS=736329108,736329107,736329109
  CRYPTOACCOUNT=
  username=$usernameprod
  password=$passwordprod
  NitroAuthorization=$NitroAuthorizationProd
  # BASEURL="https://api.tradestation.com/v3"
  BASEURL="https://sim-api.tradestation.com/v3"
elif [ "$Environment" = "pf" ]; then
  echo "using port forward"
  # export TOKEN=$(getTokenLegacy)
  export TOKEN=$(getTokenStg $usernameqa $passwordqa)
  export ACCOUNTS=61310207
  export CRYPTOACCOUNT=TCIHOUSEACCOUNT1
  # username=jsamuel
  username=$usernameqa
  password=$passwordqa
  BASEURL="http://localhost:8011" #port forwarding
fi

#BASEURL="https://crypto.api.tp.tradestation.io/v3temp"
echo "using Environment $Environment"
echo "Token = $TOKEN"
echo "ACCOUNTS = $ACCOUNTS"
echo "CRYPTOACCOUNT = $CRYPTOACCOUNT"
echo "BASEURL = $BASEURL"
echo "username = $username "
echo "nitro authorization = $NitroAuthorization"
echo "arg1=$1 arg2=$2 arg3=$3"

# check parameters
if [ "$1" = "" ]; then
  printf "\033[1;31mError: No parameters specified, usage examples ...\033[0m\n"
  help
  exit 0
elif [ "$1" = "ping" ]; then
  curl -H 'Host: api.tradestation.io' \
    -H 'accept: application/vnd.tradestation.streams.v2+json' \
    -H 'user-agent: MobileTrading/662 CFNetwork/1128.0.1 Darwin/19.4.0' \
    -H 'accept-language: en-us' \
    --compressed 'https://api.tradestation.io/mobile/us-eng/ping'
  exit 0
elif [ "$1" = "lsping" ]; then
  curl -H 'Host: api.tradestation.io' \
    -H 'accept: application/vnd.tradestation.streams.v2+json' \
    -H 'user-agent: MobileTrading/662 CFNetwork/1128.0.1 Darwin/19.4.0' \
    -H 'accept-language: en-us' \
    --compressed 'https://api.tradestation.io/mobile/us-eng/ping'
  exit 0
elif [ "$1" = "pgping" ]; then
  curl -H 'Host: api.tradestation.io' \
    -H 'accept: application/vnd.tradestation.streams.v2+json' \
    -H 'user-agent: MobileTrading/662 CFNetwork/1128.0.1 Darwin/19.4.0' \
    -H 'accept-language: en-us' \
    --compressed 'https://api.tradestation.io/mobile/us-eng/ping'
  exit 0
elif [ "$1" = "token" ]; then
  export token=$(getToken $produsername $prodpassword)
elif [ "$1" = "bs" ]; then
  export token=$(getToken $produsername $prodpassword)
  FDCN_ID=543039
  ACCOUNT_ID=5430392%20QA
  # URL="http://localhost:5000/brokerage/activity?accountId=$ACCOUNT_ID"
  URL="https://aegeus-api-master.bs-eng-usoh.nite.tradestation.io/v3/stream/account/activity?accountId=*"
  curl -v \
    --header "Authorization: Bearer $token" \
    -H "x-ts-auth-fdcn-id: $FDCN_ID" "$URL"
  exit 0
elif [ "$1" = "accounts" ]; then
  #  export token=$(getToken $produsername $prodpassword)
  export accounts=$(getAccounts)
  export accounts=$(echo $accounts | tr ' ' ',')
  # curl -v -k --http1.1 --url https://api.tradestation.com/v3/brokerage/accounts \
  #           -H "X-TS-Auth-User-ID: $username" \
  #           -H "X-Nitro-Authorization: $NitroAuthorization" \
  #           -H "Authorization: Bearer ${token}" | jq .

elif [ "$1" = "positions" ]; then
  if [ "$2" = "jq" ]; then
    curl --no-buffer -X GET "$BASEURL/us/sim/brokerageservices/positions" \
      --header "Authorization: Bearer $TOKEN" \
      --header "X-TS-Auth-User-ID: $username" \
      --header "x-lightspeed-authorization: Basic $lightspeed" | jq .
  else
    curl --no-buffer -X GET "$BASEURL/us/sim/brokerageservices/positions" \
      --header "Authorization: Bearer $TOKEN" \
      --header "X-TS-Auth-User-ID: $username" \
      --header "x-lightspeed-authorization: Basic $lightspeed"
  fi

elif [ "$1" = "balances" ]; then
  if [ "$2" = "jq" ]; then
    curl --no-buffer -X GET "$BASEURL/us/sim/brokerageservices/balances" \
      --header "Authorization: Bearer $TOKEN" \
      --header "X-TS-Auth-User-ID: $username" \
      --header "x-lightspeed-authorization: Basic $lightspeed" | jq .
  else
    curl --no-buffer -X GET "$BASEURL/us/sim/brokerageservices/balances" \
      --header "Authorization: Bearer $TOKEN" \
      --header "X-TS-Auth-User-ID: $username" \
      --header "x-lightspeed-authorization: Basic $lightspeed"
  fi
elif [ "$1" = "balances-polling" ]; then
  if [ "$2" = "jq" ]; then
    curl --no-buffer -X GET "$BASEURL/us/sim/balances" \
      --header "Authorization: Bearer $TOKEN" \
      --header "X-TS-Auth-User-ID: $username" \
      --header "x-lightspeed-authorization: Basic $lightspeed" | jq .
  else
    curl --no-buffer -X GET "$BASEURL/us/sim/balances" \
      --header "Authorization: Bearer $TOKEN" \
      --header "X-TS-Auth-User-ID: $username" \
      --header "x-lightspeed-authorization: Basic $lightspeed"
  fi
elif [ "$1" = "metrics" ]; then
  BASEURL="https://api.tradestation.io/v3/brokerage"
  curl -k -X GET "$BASEURL/metrics" \
    --header "Authorization: Bearer $TOKEN" \
    --header "X-TS-Auth-User-ID: $username" \
    --header "x-lightspeed-authorization: Basic $lightspeed"

elif [ "$1" = "help" ]; then
  helpLight
  exit 0
fi

# echo "Token"
# echo $TOKEN
# export NitroAuthorizationProd=9bd0f24d221fe64d331043320ceae228466ec9cce9b9ddf1aaa4afac85cda697a82a287e286b095b
# echo $accounts
# curl -k -v \
#   --url 'https://api.tradestation.com/v3/brokerage/accounts' \
#   --header 'authorization: Bearer '$token \
#   --header 'content-type: application/json'

# server="localhost:8001"
# # server="https://lightspeed.tp-eng-usva-2.nite.tradestation.io"
# curl -k -s -X GET "$server/us/sim/brokerageservices?accountids=$account_pks&type=position" \
#     --header "Authorization: Bearer $token" --header "X-TS-Auth-User-ID: $username"
#  --header "x-lightspeed-authorization: Basic $lightspeed"
# curl -k -s -X GET "localhost:8001/us/sim/brokerageservices/positions" \
#     --header "Authorization: Bearer $token" --header "X-TS-Auth-User-ID: nbontha"

# curl -k -s -X GET 'http://localhost:8001/us-eng/sim/brokerageservices/positions' \
#   -H "authorization: Bearer $AUTH" \
#   -H "X-TS-Auth-User-ID: $username" | jq .

# token="VDRLRFI3b2dwVFhHajVXZ3h6ZWYzK2VKcXNGVC9TeTU0Q29pdXNKTloyUUZ6OVBKMWRmeFBWZWpxTThydmF4eFFzaHBibVdCOFJoTUpxS3hzY2M3cXBBcFpObWNHdFpydjMxd0FpYUZyYTd3andyK0kxTVIrbXRqR2lIS0ErcU9KTFUzZ2tDdWF0WUFyQTNhTW52V2F0R0hqVmwrLzJtR1lVeFRiT0F2SDZQdmtJZm1vMlYra3F5MDdtMjljQlB2ZzRaVk5XeTdWUzlPcnN2ZG8rSlBwUjdzMzdBaFBmc1l2ZVZzV1lZWGdZOXJWZ0tyTGZzNjlVUlIyMGlGSlBZb0hiZGgxcHoyY3UyTWY2aGdVcXc5NitkdUJXTFVEUUhwMDFXTTJONmUwT1l3VlBFb2IwWFJBM2gxQVhoZ2F5OGxrTzBHRUMyT2lSN0JubUVJWFBEMUpJUlNvekJ5QVFNaExZUkFtYTdVd3NDTGlRUHNEU3l0a1QyK3ZBVzZPYW1LcFhDTjY0eE91NlEvaDVGc1BJKzYxWE13bXZ3WGV2ck95c0phQXF3YUtmb3hrNzA0MjM3WVJlb1NKRUlKbGZVeS8wcHZrMzBtd0s3RDBHcFhTbXRNWXhrQUdXcU1Qdi9wOEhTSnFoU2hoVnJXWGZkZklFeFV1TDdZTjRoRWJaOUQ5dXpjOEM5cXlXWGlmMFVWWVl4Z3ZHQmROaiszekFLMHdzNDdia1hFaEcwdXZNN2ZpNnZ3VVFJUFVuSzBYR29lUTcvb3JrVUIrL0ZwclIwbzJJK3Rldz09"
# username=nbontha
# server="localhost:8001"
# curl -s -X GET "$server/us/sim/brokerageservices/positions" \
#  --header "Authorization: Bearer $token"   --header "X-TS-Auth-User-ID: $username"

# curl -s -X GET "$server/us/sim/brokerageservices/positions" \
#  --header "Authorization: Bearer $token"   --header "X-TS-Auth-User-ID: $username"

# curl 'https://sim-api.tradestation.com/v2/accounts/736329107,736329108,736329109/positions?oauth_token=OUpOc21melFxTU1vNHZDVGo4Q1l2ZUxwbGJ6MlRrZkFnZnphVE8xSzIwbTYyVWp5dzdZeWdpKzQ0UjY1cHRlWlY5WWp1bm1ORDNQK0pmSWJpc045em45dXFKUG1TbElaVEQ5R0RhR0RvU0xMRzZnNm54VERRaWVMNXN6REhuVnlFakw5TzhTdFAzYzZVZWlEd1BRTndGNTBScTR4SnhoOGtVN0RRbXZEV1h2cndYUFpoS2hRVUhoWEtSMXVvZTYvOHR3U0wxNkp5cVAxSEVFNDJLSVA2YWdCQ0FyamNTTHBEZ3RRQjdrOUhabHk0RDZTakNvdTZ1Uk45aHJiektibzRDNlpsOXN4S2ovbXJ5dTRyVTFFeVNzUXRhTXlDcDl2OVMvVDlDSjZOcEhCQUpRY1FaUDhQUE1ZM0ZnOE1ZaGh0RzU5UkFVWHgzdXlzdXYvcmpZaitZblVFTkVmSVRHU2t6SUc3aFFoSnV4WkdDVGRRd3grVXhwODlsbEtzM3o3M3FhZzZRU0E2TzZVdkI0N3pYZ2tQRVZYTld6aE5ydkY2bTkvcjIwcEgzWjZBMFBNcll3aTh2aGU2REE4WUtuU1dycU83ZWxFTGFZcFdNOElSZlZVTzBCdldLYlN5TWxGV2c0T1ZuQW1RbTN2cWQvazF5WmZWOGhLemZnRFcrVDRxdk4rSVBXZWxjV2w0dkhSWGVWYmZSRkYrQ2EzdzVlRkdTU1gvUllxbHZGbDc0aktpZnlIdHlYTlJWVlFPY1pNY0laUkg0ejllbjY3SzRybnhCZVhMZz09' \
#   -H 'authority: sim-api.tradestation.com' \
#   -H 'pragma: no-cache' \
#   -H 'cache-control: no-cache' \
#   -H 'accept: application/json' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36' \
#   -H 'origin: https://sim.webtrading.tradestation.com' \
#   -H 'sec-fetch-site: same-site' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'referer: https://sim.webtrading.tradestation.com/' \
#   -H 'accept-language: en-US,en;q=0.9' \
#   --compressed

# SIM729546M
# accounts="SIM1227091F"
# account_pks="736329107"
# account_pks="736329108,736329109" #,25229201,25229202,47685307,47685308,47685309,47685310"
# token="ODJLR2ZaQ1Q0OHJjQklWY09oRUZVbUZNaDNsR2tkWHdoUnd1a1VWWGpiM0lhQVpHSEdKVHQvMDdWeEVhcTl1Z3JZN2Y0QjFQc2VhN3MzWnplQ2VQOVBOUnNueUVEMEdaYVk4dFF6YVp4MTQzL2N6bjFtTlJFZlQwb2tydXpGbXNJR21rdk03SWd1RGhJVHFnR3RpdjJDSG1janY1UE9RUHEycEVFNEdVNEpJdFR6WTRqWHhHREVabGhJMmVCNTV2ZjNxaGpnNEkzdGE1aEk2SnZ3bGozQ3hJMzRJTi96MG9qYXExeVBXSzhwdUdqazVqTW9aQUZocTRnU0FINm9lZjBUeExMczBESmlUTStHTkNZSDhYK0xJZ2R3RExlYm1LOStLTFljNnZjQkVpb1lFa2s0ZWlZRE9jbXhlYVFDN2taV0c5NnRPYzFEdkVnSlRkNmdtcGFxalFGOHRDY2ovcTNXWndabDJtSlVyTWROWlpFWW9CekcvNzBuMTFKSHV3akVCamU0RnUvcEV4aUx3a1Z1ZFJKVDNwcVpla0Urb2NKMFMvNVRMZjVlelI2VnRBN2FsbnNvaVVpZnJqNEJndk9xZno1UmFZYTBvcDJlbUE5Q1FnMExwNnpnVFRONkNnNHVsb1Z6eVRTNHV4SHdHS2FUbVVxMDhub0xxOWFhTWZtaXVzeUkvZTFtRm9SSysrVlR2MnFoeUlWK3ZJOG9OL1RaUG9QMUVuWDRINWU4RkpZRzdpQmtTaUhyTkdGZDBxeXQvb0RwVFBwRjYyVUdTL21RUjBFQT09"
# curl -k -s "https://sim-api.tradestation.com/v3/brokerage/activity?accountId=$accounts"  --header "Authorization: Bearer $token"
# 55018139c6e60cec307562a8c5fa9590b707ab48
# https://aegeus-api-master.bs-sim-usoh.nite.tradestation.com
# sim-api.tradestation.com
# secret="5366CF20-914A-4EE9-8CD7-85874103A597"
# key="8660A4C6-4858-4661-8CB2-B2B142B34D75"
# lightspeed="bW9iaWxlOnRyYWRlMTIzc3RhdGlvbg=="
# curl -k -s "https://api.tradestation.io/mobile/us/sim/brokerageservices?accountids=$accounts" --header "Authorization: Bearer $token"
# server="localhost:8004"
# server="https://lightspeed.tp-eng-usva-2.nite.tradestation.io"
# curl -k -s -X GET "$server/us/sim/brokerageservices?accountids=$account_pks&type=position" \
# --header "Authorization: Bearer $token" --header "X-TS-Auth-User-ID: $username"
#  --header "x-lightspeed-authorization: Basic $lightspeed"

# curl -H 'Host: localhost:8001' \
#   -H 'User-Agent: MobileTrading/662 CFNetwork/1128.0.1 Darwin/19.6.0' \
#   -H 'Accept: application/json' \
#   -H 'Accept-Language: en-us' \
#   -H 'Authorization: Basic QjlBRkQ5NzAtQUZBMy00NjkwLTgzNzEtRDZGRjIzODg3MDM4OkUwNTIzNjYwLUVFN0YtNEI1My04ODdGLTlGNDA0NzEzMDQwQw==' \
#   --data "password=testingnat9&username=nbontha&grant_type=password" \
#   --compressed 'http://localhost:8001/us/sim/v2/security/authorize'

# curl -H 'Host: sim-api.tradestation.com' \
#       -H 'User-Agent: MobileTrading/662 CFNetwork/1128.0.1 Darwin/19.6.0 lightspeed/DEV.00000000' \
#       -H 'Accept: application/json' \
#       -H 'Accept-Language: en-us' \
#       -H 'Authorization: Basic QjlBRkQ5NzAtQUZBMy00NjkwLTgzNzEtRDZGRjIzODg3MDM4OkUwNTIzNjYwLUVFN0YtNEI1My04ODdGLTlGNDA0NzEzMDQwQw==' \
#       --data "password=testingnat9&username=nbontha&grant_type=password" \
#       --compressed 'https://sim-api.tradestation.com/v2/security/authorize'

# curl -H 'Host: localhost:8001' \
#     -H 'X-TS-Auth-User-ID: nbontha' \
#     -H 'Accept: application/json' \
#     -H 'User-Agent: MobileTrading/662 CFNetwork/1128.0.1 Darwin/19.6.0' \
#     -H 'Authorization: Bearer dGE2UFQzYmpnUUNrUGphRU4xeWNLeld1NnowbUsyQjRXYW5IOExiSWI0cERWb2x6UzEzRkdSbCtIN2Vra0Z2MEJsU2gxQlpESjRNVEVkbTRvSzRhaWV6bmt6OU1YUnFuOHdoVFA4RUY2bUFnR1hzQmkwajgveFVZK3hjQ091dU5rTDh1RG5YV2g4YnEwanF6dmNLeS9GQ3JUVlJxbmg1OVNsekZRQ1RaMlJQQTltMHJKK2haZStiMUFiNkpKS05XaGJQSmlwZ25VcmdxUzRiS3FUanJXd3pwVGZaMEoxVmxFMUpLMjNjSlBML3RDWS80TWpjTW9aTDdBeVRBeXlHRlhIQ3RKU0pXOFIxNWVjWkJ1alNLcE1zaER2Nkh0RHU0V0dWWS9PamtsZTZCMHd2K3c0Y3l4WUZOaTJVQmdQUWwxckFpSzhTZEpKZDVDWlYyZnNJdGU0Q29sQitsU1BiOCtkNjNGazljcG93c3FiVWN4L2lOS1BaaWRRbHY2RnZ1dzdGMldZZkR1akQ0R3Erd1JFZEZuQmZFVUpXMmJxNlVJTGw2VGZHcVlzcGQxbTlsd2xsYUxveURaQVJnQWIzZ0c2MHlUZFQvVE5FaGtLdDBKaitsejV3b3FtTFhSQWVRMy9MOE54bldOaTZxQ3dkdkloWk91aTJwejgvUG93eGlLbG8zWFpOdUZGbjhGcGl3QWFubXB2enN2THM4Zit3Um8zSlVFWk9TTllRPQ==' \
#     -H 'Accept-Language: en-us' \
#     --compressed 'http://localhost:8001/us/sim/login'

# My Accounts
# [{
# 	"Alias": "",
# 	"AltId": null,
# 	"CanDayTrade": true,
# 	"ClearingID": 40,
# 	"Currency": "USD",
# 	"DayTradingQualified": true,
# 	"DisplayName": "SIM1227091F",
# 	"IsStockLocateEligible": false,
# 	"Key": 736329107,
# 	"Name": "SIM1227091F",
# 	"OptionApprovalLevel": 0,
# 	"PatternDayTrader": false,
# 	"Settings": {
# 		"CryptoEnabled": false,
# 		"EnrolledInRegTProgram": false,
# 		"RequiresBuyingPowerWarning": false
# 	},
# 	"Status": "A",
# 	"StatusDescription": "Active",
# 	"Type": "F",
# 	"TypeDescription": "Futures"
# }, {
# 	"Alias": "",
# 	"AltId": null,
# 	"CanDayTrade": true,
# 	"ClearingID": 1000,
# 	"Currency": "USD",
# 	"DayTradingQualified": true,
# 	"DisplayName": "SIM1227090M",
# 	"IsStockLocateEligible": true,
# 	"Key": 736329108,
# 	"Name": "SIM1227090M",
# 	"OptionApprovalLevel": 5,
# 	"PatternDayTrader": false,
# 	"Settings": {
# 		"CryptoEnabled": false,
# 		"EnrolledInRegTProgram": true,
# 		"RequiresBuyingPowerWarning": true
# 	},
# 	"Status": "A",
# 	"StatusDescription": "Active",
# 	"Type": "M",
# 	"TypeDescription": "Margin"
# }, {
# 	"Alias": "",
# 	"AltId": null,
# 	"CanDayTrade": true,
# 	"ClearingID": 200,
# 	"Currency": "USD",
# 	"DayTradingQualified": true,
# 	"DisplayName": "SIM1227092X",
# 	"IsStockLocateEligible": false,
# 	"Key": 736329109,
# 	"Name": "SIM1227092X",
# 	"OptionApprovalLevel": 0,
# 	"PatternDayTrader": false,
# 	"Settings": {
# 		"CryptoEnabled": false,
# 		"EnrolledInRegTProgram": false,
# 		"RequiresBuyingPowerWarning": false
# 	},
# 	"Status": "A",
# 	"StatusDescription": "Active",
# 	"Type": "X",
# 	"TypeDescription": "Forex"
# }]
