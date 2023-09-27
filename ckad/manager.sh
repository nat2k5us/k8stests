kubectl describe  po pod1 | grep -i state: | awk  '{ print $2 }'
