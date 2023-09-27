## How to install and use the bitnami redis chart

```
helm pull bitnami/redis --untar --untardir redis
```

## Installing the redis chart into k8s.io

```
helm install  redis1 charts/redis -f charts/redis/values.yaml --dry-run    

helm install  redis1 charts/redis -f charts/redis/values.yaml
```

Redis Display Output |  
----------------------------------------------------------------|
 **Please be patient while the chart is being deployed**

Redis&trade; can be accessed on the following DNS names from within your cluster:

    redis1-master.default.svc.cluster.local for read/write operations (port 6379)
    redis1-replicas.default.svc.cluster.local for read-only operations (port 6379)

To get your password run:

    export REDIS_PASSWORD=$(kubectl get secret --namespace default redis1 -o jsonpath="{.data.redis-password}" | base64 --decode)

To connect to your Redis&trade; server:

1. Run a Redis&trade; pod that you can use as a client:

   kubectl run --namespace default redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:6.2.6-debian-10-r169 --command -- sleep infinity

   Use the following command to attach to the pod:

   kubectl exec --tty -i redis-client \
   --namespace default -- bash

2. Connect using the Redis&trade; CLI:
   REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis1-master
   REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis1-replicas

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace default svc/redis1-master : &
    REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p | 
 
 
## Connecting to Redis with Auth
 - if you get AUTH fail on connect - with Auth is required to connect then get the password from the command redis installation provided to you earlier
  ```
  redis-cli
  ```
  then at the prompt connect
  ```
  127.0.0.1:6739> AUTH your_pass
  ```

 - 

## Using Go with Redis in K8s
```
https://github.com/go-redis/redis
```
