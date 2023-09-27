#!/usr/local/bin/bash
#export TOKEN=$(dotnet /Users/nbontha/dev/ts/gettokennetcore/bin/Debug/netcoreapp2.2/publish/token.dll)
#export NITROID=$(pgrep -f nitro-darwin-amd64)
#echo $TOKEN
#echo $NITROID
#curl -L http://pinterest.com/
# {"access_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlFqY3lPVUZEUkVRd056UXdORUV5UkRaRVJqQkRRa0kyTWtSRVJqbEROREpCUVRSR01EYzBOUSJ9.eyJodHRwOi8vdHJhZGVzdGF0aW9uLmNvbS91c2VybmFtZSI6IlRDSWhvdXNlYWNjb3VudDEiLCJodHRwOi8vdHJhZGVzdGF0aW9uLmNvbS9mZGNuX2lkIjoiNjQzMDI1NSIsImh0dHA6Ly90cmFkZXN0YXRpb24uY29tL29ueXhfaWQiOjIzMTA3NzIsImh0dHA6Ly90cmFkZXN0YXRpb24uY29tL2NyeXB0b19pZCI6ImM4MTkwN2EwLTE5YzgtNGFmMy1iMzRmLTQ4MTU3NzNjNWI0NCIsImlzcyI6Imh0dHBzOi8vbG9naW4udHJhZGVzdGF0aW9uLmNvbS8iLCJzdWIiOiJhdXRoMHw2NDMwMjU1IiwiYXVkIjpbIjl1WWhWdjA1UDZhd0psNHpOd2lFb1ZWNTZJTmpEbDVXIiwiaHR0cHM6Ly90cmFkZXN0YXRpb24uYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTU4NDAyOTM0MiwiZXhwIjoxNTg0MDMwNTQyLCJhenAiOiI5dVloVnYwNVA2YXdKbDR6TndpRW9WVjU2SU5qRGw1VyIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUifQ.O0HuhbPVmuA2WF1r24HTg6hNqys7TOsgK-rzV8uPfIG2iDXeujgex1T9phU23l4WUdbA4yekrdaPqblk_FtMx18aB8dktmqawOMO1lMPZc-ig-D75yxPTnAqg3PnJ85IQGoigqnN6UguHibaVJhkDNyvVB5Xie6jQuP8Js_5t4B4pSArGiORmJucytJ63LFYEbdSxnPESU3q_T3EwP0zKl22nir9ZWEC-GgM9yojiBcJZB0T8Y3QpY-El4YdFBNdLqrhXHAhrt0-UJBzaYFRHs6zTOc2u8uN-F_HklF7gQTng2yXRQYqygWAqiijTuB4iH_XEbk6fZJFnTpSsQlVqA","id_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlFqY3lPVUZEUkVRd056UXdORUV5UkRaRVJqQkRRa0kyTWtSRVJqbEROREpCUVRSR01EYzBOUSJ9.eyJodHRwOi8vdHJhZGVzdGF0aW9uLmNvbS91c2VybmFtZSI6IlRDSWhvdXNlYWNjb3VudDEiLCJodHRwOi8vdHJhZGVzdGF0aW9uLmNvbS9mZGNuX2lkIjoiNjQzMDI1NSIsImh0dHA6Ly90cmFkZXN0YXRpb24uY29tL29ueXhfaWQiOjIzMTA3NzIsImh0dHA6Ly90cmFkZXN0YXRpb24uY29tL2NyeXB0b19pZCI6ImM4MTkwN2EwLTE5YzgtNGFmMy1iMzRmLTQ4MTU3NzNjNWI0NCIsIm5pY2tuYW1lIjoiamJhcnRsZW1hbiIsIm5hbWUiOiI2NDMwMjU1IiwicGljdHVyZSI6Imh0dHBzOi8vcy5ncmF2YXRhci5jb20vYXZhdGFyLzk3ZTQ2ZTdmZWE4NDQzMWVkMTFiOGY0NDg5NzYwZGM5P3M9NDgwJnI9cGcmZD1odHRwcyUzQSUyRiUyRmNkbi5hdXRoMC5jb20lMkZhdmF0YXJzJTJGNjQucG5nIiwidXBkYXRlZF9hdCI6IjIwMjAtMDMtMTJUMTY6MDg6NTguNDY1WiIsImlzcyI6Imh0dHBzOi8vbG9naW4udHJhZGVzdGF0aW9uLmNvbS8iLCJzdWIiOiJhdXRoMHw2NDMwMjU1IiwiYXVkIjoiOXVZaFZ2MDVQNmF3Smw0ek53aUVvVlY1NklOakRsNVciLCJpYXQiOjE1ODQwMjkzNDIsImV4cCI6MTU4NDAzMDU0Mn0.BXaRfpQha612hrZl6Z5Pghght-M1hAHgXlxZZ-4J-c0MZQJspjOH4lwhpPwjbWpmWJHAoaqP0sVVBkrwKoPCvhrilfQOlYlW1D_8kJb44xjo5qlt9F5zbABN9tUQdY8MxKh1H_Gz6o4TcVb4Efj1sq8bI7gkYoOZo5Fy7vb7K5C2m1NICCDoIWVfQCez4Kxq-OCgZstH_5bDk7hydKBAd9A21fN2d6P3BCWWRyMwhJwmO30lGu9-_TyLTFlfms5XxBQTk2mPU9OuO7nZGZBliVyMS_pJh61FOqFv5slYIXwcE7aNqB31mxMzJHWuQGwlRHnC5s4-hS0thbDrSi8OUw","scope":"openid profile","expires_in":1200,"token_type":"Bearer"}
YELLOW="\e[1;93m"
GREEN="\e[1;32m"
DEFAULT="\e[0m"
RED="\033[1;31m"
PRINTINPLACE="\033[0K" # The special character \033[0K represents an end of line which cleans the rest of line if there are any characters left from previous output and \r is a carriage return which moves the cursor to the beginning of the line.
#printf "\033[1;31mThis is red text\033[0m\n"
function help() {
    echo "current Environment="
    echo "Environment localhost(default) => http://127.0.0.1:8001"
    echo "QA Environment to https://crypto.api.tp.tradestation.io/v3temp"
    echo "STG Environment to https://api.stg.tradestation.io/v3"
    echo "Prod Environment to https://api.tradestation.com"
    echo "Port-Forward Environment to http://localhost:8111"
    echo "\nUsage : \
    \n\t n.sh [command] [symbol] [filter] \
    \n
    \n\t Commands:
    \n\t\t accounts - gets the accounts \
    \n\t\t orders - gets all the orders \
    \n\t\t balances - gets the account balances \
    \n\t\t wallets - gets the wallets \
    \n\t\t ho - gets historical orders \
    \n\t\t ho-since 10-11-2019 - gets historical orders since date \
    \n\t\t bodbalances \
    \n\t\t symbols MSFT,AAPL \
    \n\t\t symbols AAPL 200117P292.5 - Options Symbol \
    \n\t\t quote MSFT,AAPL  - streaming quotes \
    \n\t\t sq-nobuffer SPY Last,.AskSize,.BidSize \
    \n\t\t sq-array SPY Last,.AskSize,.BidSize \
    \n\t\t bars SPY?interval=5&unit=minute&barsBack=2"

}

# check parameters
if [ "$1" = "" ]; then
    printf "\033[1;31mError: No parameters specified, usage examples ...\033[0m\n"
    help
    exit 0
elif [ "$1" = "timer" ]; then
    T=$((SECONDS + ($2 * 60)))

    while ((T > SECONDS)); do
        # \r returns to the beginning of the line and overwrites.
        COUNTDOWN=$(printf "\r%02d: %02d" $(((T - SECONDS) / 60)) $(((T - SECONDS) % 60)))
        # echo $COUNTDOWN
        figlet -f starwars $COUNTDOWN
        sleep 1
    done
    echo
    exit 0
elif [ "$1" = "time" ]; then
    if [ "$2" = "" ]; then
        FONTFAMILY=starwars
    else
        FONTFAMILY=$2
    fi
    while (true); do
        # \r returns to the beginning of the line and overwrites.
        now=$(date +"%T")
        figlet -f $FONTFAMILY $now
        sleep 1
    done
    echo
    exit 0
elif [ "$1" = "colors" ]; then
    # Color 0=black 255=white , below <196>m is foreground and <22m> is background color
    # printf '\e[38;5;196m Foreground color: red\n'
    # printf '\e[48;5;22m Background color: black\n'
    for ((i = 16; i < 256; i++)); do
        printf "\e[48;5;${i}m%03d" $i
        printf '\e[0m'
        [ ! $((($i - 15) % 6)) -eq 0 ] && printf ' ' || printf '\n'
    done
    # Change colors back to the defaults when exit/logout
    # alias exit 'echo -n "^[]110;^G^[]111;^G";""exit'
    exit 0
elif [ "$1" = "time12" ]; then
    while (true); do
        # \r returns to the beginning of the line and overwrites.
        read -n 1 -s -t 0.1
        RETVAL=$?
        if [ "$RETVAL" != "142" ]; then
            if [ "$start" != "" ]; then
                end=$(gdate +%s%N)
                runtime=$(((end - start) / 1000000))
                printf "$YELLOW Timer: $runtime ms \n"
                printf "$DEFAULT"
                start=""
            else
                start=$(gdate +%s%N)
                echo "start time set to $start"
            fi
        fi
        # ok? echo && continue
        [ $RETVAL -eq 0 ] && echo -E "$REPLY" && continue
        # no timeout ? (EOF or error) break
        [ $RETVAL -gt 128 ] || break

        now=$(date +"%r")
        # figlet -f $FONTFAMILY $now
        # echo -ne "$now $PRINTINPLACE\r"
        echo -ne "$now \n"
        # sleep 1
    done
    echo
    exit 0
elif [ "$1" = "fig-time12" ]; then
    if [ "$2" = "" ]; then
        FONTFAMILY=starwars
    else
        FONTFAMILY=$2
    fi
    while (true); do
        now=$(date +"%r")
        figlet -f $FONTFAMILY $now
        sleep 1
    done
    echo
    exit 0
elif [ "$1" = "eject-ext" ]; then
    find /Volumes -maxdepth 1 -not -user root -print0 | xargs -I {} diskutil unmount force "{}"
    #    diskutil list | grep external | cut -b 1-10 | xargs -I {} diskutil unmount force "{}"
    exit 0
elif [ "$1" = "help" ]; then
    help
    exit 0
fi

read -n 1 -p "Please choose Port-(F)orward, (Q)A, (S)taging, (l)ocalhost or (P)rod? " ans

case $ans in
q | Q)
    export Environment=qa
    ;;
s | S)
    export Environment=stg
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
# account data needs to be set before get token
export usernameprod=TCIHOUSEACCOUNT1
export passwordprod=Cryptotrade123
export usernamestg=TCIQA4
export passwordstg=poweruser4
export cryptoacctstg=31000265
export cashacctstg=31000265
export futuresacctstg=210J1679
export marginacctstg=31001916
export usernameqa=TCIQA1
export passwordqa=poweruser1

#echo "getting token"
function getTokenLegacy() {
    curl --request POST \
        -k \
        --url 'https://api.tradestation.com/v2/security/authorize' \
        --header 'content-type: application/x-www-form-urlencoded' \
        --data "grant_type=password&username=jsamuel&password=itrade123&client_id=D766B4B8-DAE8-11DF-B7DF-28DDDFD72085&client_secret=558E713B-CC7B-49ED-B70A-A59C1B8779C3&response_type=token" |
        jq -r .access_token
}

function getTokenQA() {
    echo "getting token QA"
    curl --request POST \
        -k \
        --url 'https://tradestation-qa.auth0.com/oauth/token' \
        --header 'content-type: application/x-www-form-urlencoded' \
        --data grant_type="http://auth0.com/oauth/grant-type/password-realm" \
        --data username=omgmkob@tradestation.com \
        --data password=Trade123 \
        --data audience="https://api.tradestation.io" \
        --data scope=openid+profile+MarketData+ReadAccount+Trade+HotLists+News+Matrix+Crypto \
        --data client_id="GbHvpF6vhzMA4xoLrv9t9UBDdl2fTUrI" \
        --data client_secret="kJclVpoM76vmXiabXQsp-aakqwPL1hii5B9hC8kGrEjw1pwPPcejPi15a4cP9NFj" \
        --data realm=CryptoDEVAuth0DBTemp |
        jq -r .access_token
}

function getTokenProd() {

    curl --request POST \
        -k \
        --url 'https://login.tradestation.com/oauth/token' \
        --header 'content-type: application/x-www-form-urlencoded' \
        --data grant_type="http://auth0.com/oauth/grant-type/password-realm" \
        --data username=$usernameprod \
        --data password=$passwordprod \
        --data audience="https://api.tradestation.com" \
        --data scope=openid+profile+MarketData+ReadAccount+Trade+Matrix+Crypto \
        --data client_id="Sg8Fa1mdIC7IAEYxbHw6wZn4gzjLccl7" \
        --data client_secret="DPVVY_m0fnwNQT3dxj-IMMG8O5MaU25ZLQgeZmhuBteywovhML7UERHcS-3zPI2G" \
        --data realm=auth0-api-connection |
        jq -r .access_token

}

function getTokenStg() {
    # https://tradestation-stg.tslogin-dev.auth0.com/oauth/token << New
    # 'https://login-stg.tradestation.io/oauth/token' << Old
    curl --request POST \
        -k \
        --url 'https://tradestation-stg.tslogin-dev.auth0.com/oauth/token' \
        --header 'content-type: application/x-www-form-urlencoded' \
        --data grant_type="http://auth0.com/oauth/grant-type/password-realm" \
        --data username=$usernamestg \
        --data password=$passwordstg \
        --data audience="https://api.tradestation.io" \
        --data scope=openid+profile+MarketData+ReadAccount+Trade+Matrix+Crypto \
        --data client_id="kZv8C65sif5KwWfIde0PMI0jcnK0jx8U" \
        --data client_secret="WNGWhE-v_MotIEOHzoVOFF_iSJ4j3GP8O8dgJQcbMeoOpnT12af-l8aOcH_CbKh_" \
        --data realm=auth0-api-connection |
        jq -r .access_token

}

curlRequestEndpoint() {
    ENDPOINT=$1
    SYM=$2
    if [ "$2" = "" ]; then
        FULLURL=$BASEURL/$ENDPOINT
    else
        FULLURL=$BASEURL/$ENDPOINT/"$2"
    fi
    # echo "full Curl => curl -k --url $FULLURL -H X-TS-Auth-User-ID: $username -H Authorization: Bearer ${TOKEN} | jq ."
    echo "fullurl => $FULLURL"

    curl -k --url $FULLURL \
        -H "X-TS-Auth-User-ID: $username" \
        -H "X-Nitro-authorization: 9bd0f24d221fe64d331043320ceae228466ec9cce9b9ddf1aaa4afac85cda697a82a287e286b095b" \
        -H "Authorization: Bearer ${TOKEN}" | jq .
}

nowInMs() {
    # echo "$(($(gdate +'%s + %-N')))"
    echo $(gdate +%s%N)
}

timeit() {
    start=$(date +%s%N)
    end=$(date +%s%N)
    runtime=$(((end - start) / 1000000))
    echo "$runtime ms"
}

echo "Making calls using token..."
if [ "$Environment" = "" ]; then
    BASEURL="http://127.0.0.1:8001"
    export TOKEN=$(getTokenStg)
elif [ "$Environment" = "localhost" ]; then
    export TOKEN=$(getTokenStg)
    BASEURL="http://localhost:8001"
    username=$usernamestg
    password=$passwordstg
elif [ "$Environment" = "qa" ]; then
    export TOKEN=$(getTokenQA)
    export ACCOUNTS=mkobCrypto,1929977952%20QA,192997795%20QA,1929977951%20QA,FX192997795%20QA,omgmkob_RegTConfirm,omgmkob_RegTNoConfirm
    BASEURL="https://crypto.api.tp.tradestation.io/v3temp"
elif [ "$Environment" = "eng" ]; then
    BASEURL="https://api.stg.tradestation.io/v3"
elif [ "$Environment" = "stg" ]; then
    export TOKEN=$(getTokenStg)
    export ACCOUNTS=marginacctstg,futuresacctstg,cashacctstg
    CRYPTOACCOUNT=$cryptoacctstg
    username=$usernamestg
    password=$passwordstg
    BASEURL="https://api.stg.tradestation.io/v3"
elif [ "$Environment" = "prod" ]; then
    echo "using prod"
    export TOKEN=$(getTokenProd)
    export ACCOUNTS=31000261
    CRYPTOACCOUNT=61380005
    username=$usernameprod
    password=$passwordprod
    BASEURL="https://api.tradestation.com/v3"
elif [ "$Environment" = "pf" ]; then
    echo "using port forward"
    export TOKEN=$(getTokenLegacy)
    export ACCOUNTS=61310207
    export CRYPTOACCOUNT=TCIHOUSEACCOUNT1
    username=jsamuel
    BASEURL="http://localhost:8111" #port forwarding
fi

#BASEURL="https://crypto.api.tp.tradestation.io/v3temp"
echo "using Environment $Environment"
echo "Token = $TOKEN"
echo "ACCOUNTS = $ACCOUNTS"
echo "CRYPTOACCOUNT = $CRYPTOACCOUNT"
echo "BASEURL = $BASEURL"
echo "username = $username"
echo "arg1=$1 arg2=$2 arg3=$3"

if [ "$1" = "orders" ]; then
    FULLURL=$BASEURL/brokerage/accounts/$ACCOUNTS/orders
    echo "full Curl => curl -k --url $FULLURL -H 'X-TS-Auth-User-ID: $username' -H 'Authorization: Bearer '${TOKEN} | jq ."
    echo "fullurl => $FULLURL"

    curl -k --url $FULLURL \
        $BASEURL/brokerage/accounts/$ACCOUNTS/orders \
        -H "X-TS-Auth-User-ID: $username" \
        -H "X-Nitro-authorization: 9bd0f24d221fe64d331043320ceae228466ec9cce9b9ddf1aaa4afac85cda697a82a287e286b095b" \
        -H "Authorization: Bearer ${TOKEN}" |
        jq .

elif [ "$1" = "deltix" ]; then
    curl -k --url 'https://crypto.tradestation.com/api/v1/securities' -H 'X-Deltix-Nonce: 1583849636450' -H 'authorization: Bearer '$TOKEN | jq .

elif [ "$1" = "version" ]; then
    if [[ "$BASEURL" == *"localhost"* ]]; then
        curl GET -k -v --url "$BASEURL/.version" | jq .
    else
        BASEURL=$(echo $BASEURL | cut -d"/" -f 3) # cut -d(delimiter)
        echo "BASEURL => $BASEURL"
        curl GET -k -v --url "$BASEURL/.version" | jq .
    fi
elif [ "$1" = "status" ]; then
    if [[ "$BASEURL" == *"localhost"* ]]; then
        curl GET -k -v --url "$BASEURL/status" | jq .
    else
        # BASEURL=$(echo $BASEURL | cut -d"/" -f 3) # cut -d(delimiter)
        echo "url => $BASEURL/nitro/status"
        curl GET -k -v --url "$BASEURL/nitro/status" | jq .
    fi

elif [ "$1" = "accounts" ]; then
    FULLURL=$BASEURL/brokerage/accounts
    echo "full Curl => curl -k --url $FULLURL -H X-TS-Auth-User-ID: $username -H Authorization: Bearer ${TOKEN} | jq ."
    echo "fullurl => $FULLURL"

    if [[ "$BASEURL" == *"localhost"* ]]; then
        curl GET -k -v --url $FULLURL \
            -H "X-TS-Auth-User-ID: $username" \
            -H "Authorization: Bearer $TOKEN" \
            -H "X-Nitro-Authorization: test" | jq .
    else
        curl -v -k --url $FULLURL \
            -H "X-TS-Auth-User-ID: $username" \
            -H "X-Nitro-Authorization: 9bd0f24d221fe64d331043320ceae228466ec9cce9b9ddf1aaa4afac85cda697a82a287e286b095b" \
            -H 'Authorization: Bearer '${TOKEN} | jq .
    fi
elif [ "$1" = "token" ]; then
    echo "token $Environment = $TOKEN"
elif [ "$1" = "token-legacy" ]; then
    echo "token $Environment = $TOKEN"
    export TOKEN=$(getTokenLegacy)
    echo "token legacy (v2)= $TOKEN"
elif [ "$1" = "wallets" ]; then
    FULLURL=$BASEURL/brokerage/accounts/"$CRYPTOACCOUNT"/wallets
    echo "fullurl => $FULLURL"
    start=$(gdate +%s%N)
    curl -v -k --url $FULLURL \
        -H "X-TS-Auth-User-ID: $username" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -H "X-Nitro-authorization: 9bd0f24d221fe64d331043320ceae228466ec9cce9b9ddf1aaa4afac85cda697a82a287e286b095b" \
        -D "scope=openid+profile+MarketData+ReadAccount+Trade+Matrix+Crypto" \
        -H "Authorization: Bearer ${TOKEN}" |
        jq .

    end=$(gdate +%s%N)
    runtime=$(((end - start) / 1000000))
    echo "$runtime ms"
elif [ "$1" = "wallets-load" ]; then
    start=$(gdate +%s%N)
    # for i in $(seq 1 $2); do
    #     curlRequestEndpoint "brokerage/accounts/$CRYPTOACCOUNT/wallets"
    # done
    bombardier -c $2 -d 60s -l -m GET \
        -H "X-TS-Auth-User-ID:"$username \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -H "X-Nitro-authorization: test" \
        -H "Authorization: Bearer "$TOKEN \
        $BASEURL/brokerage/accounts/$CRYPTOACCOUNT/wallets
    end=$(gdate +%s%N)
    runtime=$(((end - start) / 1000000))
    printf "$YELLOW GET wallets took  $runtime ms"
elif [ "$1" = "ordergroups" ]; then
    FULLURL=$BASEURL/brokerage/ordergroups
    echo "fullurl => $FULLURL"
    curl --request POST \
        -k -v \
        --url $FULLURL \
        --header "X-TS-Auth-User-ID: $username" \
        --header 'content-type: application/json' \
        --header 'x-nitro-authorization: test' \
        --data '{"type":"OCO","Orders":[{"AssetType":"stock","Symbol":"GOOG","TimeInForce":{"Duration":"gtc"},"OrderType":"limit","LimitPrice":"3.14","AccountID":"31001905","Quantity":"4","TradeAction":"buy"},{"AssetType":"stock","Symbol":"AAPL","TimeInForce":{"Duration":"gtc"},"OrderType":"limit","LimitPrice":"36.14","AccountID":"31001905","Quantity":"77","TradeAction":"buy"}]}' | jq .

elif [ "$1" = "alltests" ]; then
    curlRequestEndpoint "brokerage/accounts"
    curlRequestEndpoint "brokerage/accounts/$ACCOUNTS/orders"
    curlRequestEndpoint "brokerage/accounts/$ACCOUNTS/orders"
    curlRequestEndpoint "brokerage/accounts/$CRYPTOACCOUNT/wallets"
    curlRequestEndpoint "marketdata/symbols" "MSFT"
    curlRequestEndpoint "marketdata/symbols" "BTCUSD"
    curlRequestEndpoint "marketdata/symbols" "DASHUSD"
elif [ "$1" = "ho" ]; then
    curl -v -X GET \
        $BASEURL/brokerage/accounts/$ACCOUNTS/historicalorders \
        -H "authorization: Bearer ${TOKEN}" \
        -H 'cache-control: no-cache' \
        -H 'postman-token: 7b0e630f-00f3-ca93-df46-5b3ccfb77c4a' \
        -H "X-TS-Auth-User-ID: $username" | jq .

elif [ "$1" = "ho-since" ]; then
    if [ "$2" = "" ]; then
        $2 = "10-10-2019"
    fi
    curl -v -X GET \
        $BASEURL/brokerage/accounts/$ACCOUNTS/historicalorders?since=$2 \
        -H "authorization: Bearer ${TOKEN}" \
        -H 'cache-control: no-cache' \
        -H 'postman-token: 7b0e630f-00f3-ca93-df46-5b3ccfb77c4a' \
        -H 'x-ts-auth-user-id: omgmkob' | jq .
elif [ "$1" = "bodbalances" ]; then

    FULLURL=$BASEURL/brokerage/accounts/$ACCOUNTS/bodbalances
    echo "full Curl => curl -k --url $FULLURL -H 'X-TS-Auth-User-ID: $username' -H 'Authorization: Bearer '${TOKEN} | jq ."
    echo "fullurl => $FULLURL"

    curl -k --url $FULLURL \
        -H "X-TS-Auth-User-ID: $username" \
        -H 'Authorization: Bearer '${TOKEN} | jq .

elif [ "$1" = "balances" ]; then
    FULLURL=$BASEURL/brokerage/accounts/$ACCOUNTS/balances
    echo "full Curl => curl -k --url $FULLURL -H 'X-TS-Auth-User-ID: $username' -H 'Authorization: Bearer '${TOKEN} | jq ."
    echo "fullurl => $FULLURL"
    curl -k --url $FULLURL \
        -H "X-TS-Auth-User-ID: $username" \
        -H "X-Nitro-authorization: 9bd0f24d221fe64d331043320ceae228466ec9cce9b9ddf1aaa4afac85cda697a82a287e286b095b" \
        -H "Authorization: Bearer ${TOKEN}" | jq .
elif [ "$1" = "symbols" ]; then
    if [ "$2" = "" ]; then
        echo "No Symbol Entered"
        echo "for ex. MSFT,AAPL,AMZN"
        exit 1
    fi

    FULLURL=$BASEURL/marketdata/symbols/"$2"
    echo "full Curl => curl -k --url $FULLURL -H 'X-TS-Auth-User-ID: $username' -H 'Authorization: Bearer '${TOKEN} | jq ."
    echo "fullurl => $FULLURL"

    curl -k --url $FULLURL \
        -H "X-TS-Auth-User-ID: $username" \
        -H "X-Nitro-authorization: 9bd0f24d221fe64d331043320ceae228466ec9cce9b9ddf1aaa4afac85cda697a82a287e286b095b" \
        -H "Authorization: Bearer ${TOKEN}" |
        jq .

elif [ "$1" = "quote" ]; then
    if [ "$2" = "" ]; then
        echo "No Symbol Entered"
        echo "for ex. MSFT,AAPL,AMZN"
        exit 1
    fi
    FULLURL=$BASEURL/marketdata/stream/quotes/"$2"
    echo "full Curl => curl -k --url $FULLURL -H 'X-TS-Auth-User-ID: $username' -H 'Authorization: Bearer '${TOKEN} | jq ."
    echo "fullurl => $FULLURL"

    curl --no-buffer -v -k --url $FULLURL \
        -H "X-TS-Auth-User-ID: $username" \
        -H "X-Nitro-authorization: test" \
        -H "Authorization: Bearer ${TOKEN}" | jq .
elif [ "$1" = "quotemc" ]; then
    if [ "$2" = "" ]; then
        echo "No Symbol Entered"
        echo "for ex. MSFT,AAPL,AMZN"
        exit 1
    fi
    FULLURL=$BASEURL/marketdata/stream/quotes/"$2"?maxchunks=5
    echo "full Curl => curl -k --url $FULLURL \ -H X-TS-Auth-User-ID: $username -H Authorization: Bearer ${TOKEN} | jq ."
    echo "fullurl => $FULLURL"
    echo "username => $username"

    # curl --no-buffer -k --url "https://api.stg.tradestation.io/v3/marketdata/stream/quotes/GME?maxchunks=5" \
    #     -H "X-TS-Auth-User-ID: TCIQA1" \
    #     -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlFUSkNRVVkyTXpkQlJqVTBNRVZCUXpGRk5EUTFRVFUwUVVVMlJEUTFPRGcyT0VSRk1FUTROQSJ9.eyJodHRwOi8vdHJhZGVzdGF0aW9uLmNvbS9sZWdhY3lfYXBpX2tleSI6IkUyRkM5QTY5LTc5OEUtNEIzNS1BOTNCLTI3RTlDODUzRjdCQiIsImh0dHA6Ly90cmFkZXN0YXRpb24uY29tL3VzZXJuYW1lIjoiVENJUUE0IiwiaHR0cDovL3RyYWRlc3RhdGlvbi5jb20vZmRjbl9pZCI6IjM2NDgwODg3NiIsImh0dHA6Ly90cmFkZXN0YXRpb24uY29tL29ueXhfaWQiOjE1Njk2NjksImh0dHA6Ly90cmFkZXN0YXRpb24uY29tL2NyeXB0b19pZCI6IkQxNEU3NjNDLTQwOEUtNDZEMi1CQkJFLTMwNDg4ODUxMUVBNiIsImlzcyI6Imh0dHBzOi8vbG9naW4tc3RnLnRyYWRlc3RhdGlvbi5pby8iLCJzdWIiOiJhdXRoMHwzNjQ4MDg4NzYiLCJhdWQiOlsiaHR0cHM6Ly9hcGkudHJhZGVzdGF0aW9uLmlvIiwiaHR0cHM6Ly90cmFkZXN0YXRpb24tc3RnLmF1dGgwLmNvbS91c2VyaW5mbyJdLCJpYXQiOjE1ODQ5ODUwOTAsImV4cCI6MTU4NDk4NjI5MCwiYXpwIjoia1p2OEM2NXNpZjVLd1dmSWRlMFBNSTBqY25LMGp4OFUiLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIE1hcmtldERhdGEgUmVhZEFjY291bnQgVHJhZGUgTWF0cml4IENyeXB0byIsImd0eSI6InBhc3N3b3JkIn0.aywp2kt0mC3zeVlyg3cK8bnTu3Z9HB2N6J7vvJxDclz-lxzSbpsP-12KQ-n3eICq53S4BHyZKP9cHzgiaufHQtFcVLX6YPlVPqYojgLRbeGzt7rY3EHAg_2W2H_h8QjxAVmRosIAlWTLegBEPMfNmPcKoQYnSvRUM1E7-BWYY6ogYIYSo5HcJ2GxqUWtKvuqmHVRy55vBah8GB8cjRo0pZTmqIom-l5Z8xEOIE3MBep0ZFGms8OHZxrZBRA0ao736l727yn5DXKAFeM63gO-ZG7SGpOM6Sb5FjnLWsX3O-N4W_CVzRdLiljYermj3M6GJ8L9SnPpC_IgNEIExCzjPw" \
    #     -H "X-Nitro-Authorization: test" | jq .

    curl --no-buffer -k --url $FULLURL \
        -H "X-TS-Auth-User-ID: $username" \
        -H "X-Nitro-authorization: 9bd0f24d221fe64d331043320ceae228466ec9cce9b9ddf1aaa4afac85cda697a82a287e286b095b" \
        -H "Authorization: Bearer ${TOKEN}" | jq .

elif [ "$1" = "sq-nobuffer" ]; then
    if [ "$2" = "" ]; then
        echo "No Symbol Entered"
        echo "for ex. MSFT,AAPL,AMZN"
        exit 1
    fi

    FULLURL=$BASEURL/marketdata/stream/quotes/"$2"
    echo "full Curl => curl -k --url $FULLURL -H 'X-TS-Auth-User-ID: $username' -H 'Authorization: Bearer '${TOKEN} | jq ."
    echo "fullurl => $FULLURL"

    curl --no-buffer -k --url $FULLURL \
        -H "X-TS-Auth-User-ID: $username" \
        -H "X-Nitro-authorization: 9bd0f24d221fe64d331043320ceae228466ec9cce9b9ddf1aaa4afac85cda697a82a287e286b095b" \
        -H "Authorization: Bearer ${TOKEN}" | jq .$3

elif [ "$1" = "sq-array" ]; then
    if [ "$2" = "" ]; then
        echo "No Symbol Entered"
        echo "for ex. MSFT,AAPL,AMZN"
        exit 1
    fi

    FULLURL=$BASEURL/marketdata/stream/quotes/$2
    echo "full Curl => curl -k --url $FULLURL -H 'X-TS-Auth-User-ID: $username' -H 'Authorization: Bearer '${TOKEN} | jq ."
    echo "fullurl => $FULLURL"
    curl --no-buffer -k --url $FULLURL \
        -H "X-TS-Auth-User-ID: $username" \
        -H "X-Nitro-authorization: 9bd0f24d221fe64d331043320ceae228466ec9cce9b9ddf1aaa4afac85cda697a82a287e286b095b" \
        -H "Authorization: Bearer ${TOKEN}" | jq --compact-output [.$3]

elif [ "$1" = "bars" ]; then
    if [ "$2" = "" ]; then
        echo "No Symbol Entered"
        echo "for ex. MSFT,AAPL,AMZN"
        exit 1
    fi

    FULLURL=$BASEURL/marketdata/stream/barcharts/"$2"
    echo "full Curl => curl -k --url $FULLURL -H 'X-TS-Auth-User-ID: $username' -H 'Authorization: Bearer '${TOKEN} | jq ."
    echo "fullurl => $FULLURL"
    curl --no-buffer -k --url $FULLURL \
        -H "X-TS-Auth-User-ID: $username" \
        -H "X-Nitro-authorization: 9bd0f24d221fe64d331043320ceae228466ec9cce9b9ddf1aaa4afac85cda697a82a287e286b095b" \
        -H "Authorization: Bearer ${TOKEN}" | jq --compact-output [.$3]

else

    echo "invalid parameter - see help"
    help
    #curl --no-buffer -v -X GET -H "authorization: Bearer ${TOKEN}" $BASEURL/marketdata/stream/quotes/$2 | jq .
fi

# curl  GET -k -v --url "http://localhost:8001/brokerage/accounts" \
#      -H "X-TS-Auth-User-ID: tciqa4" \
#     -H "Authorization: Bearer $TOKEN" \
#      -H 'X-Nitro-Authorization: test'
