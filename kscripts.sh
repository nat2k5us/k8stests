#!/usr/bin/env bash

# tail follow logs for pod
function k-cm() {
    values=""
    for var in "$@"
        do
            if [ "$var" != "$1" ]; then
                values="$values$ --from-literal=$var"
            fi
        done
        echo "values => $values"
        kubectl create cm $values
}