kubectl describe  po pod1 | grep -i status: | awk 'FS=":" { print $2 }'
