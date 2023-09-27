
### Steps

```kubectl apply -f deployment.yml```

### Output

> deployment.apps/frontend created
> service/flask-svc created

```kubectl get svc -o wide```

NAME         TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE   SELECTOR
flask-svc    LoadBalancer   10.110.24.30     localhost     80:30254/TCP   10m   app=frontend

```curl localhost```

> Welcome to flask

### Auto scale the pods command

```kubectl autoscale deployment frontend --cpu-percent=50 --min=1 --max=5```

>horizontalpodautoscaler.autoscaling/frontend autoscaled

**Get the HPA status**

```$ kubectl get hpa```

NAME       REFERENCE             TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
frontend   Deployment/frontend   2%/50%    1         5         2          66s

**Watch the installation

```watch -n 1 kubectl get hpa,deployment```

**Load test the pods - monitoring of the pods is by externaly by metrics**

```bash
while true
do
curl -s localhost > /dev/null
done &
```

**kill the curl instances to take away the load test**

`ps -ef | grep curl | grep -v grep | awk '{print $3}' | xargs kill`

- Even if the CPU spikes to 100% or more, the Autoscaler has a limit regarding how many additional Pod it spawns in one run. It will at most double the number of existing replicas.
- The Autoscaler also has a limit of how frequent it will scale up or down. For scaling up, that is 3 minutes between every scale operation and the other. When scaling down, the period becomes 5 minutes.
- The HPA is no more than another Kubernetes resource. So, you can edit the HPA once it has been deployed by using the kubectl edit subcommand. For example kubectl edit hpa frontend
