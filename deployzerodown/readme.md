``` kubectlrun --generator=run-pod/v1 -it --rm load-generator \
  --image=busybox \
  --replicas=1 \
  --requests=cpu=100m,memory=256Mi \
  --limits=cpu=200m,memory=512Mi \
  --namespace=nitro```

``` kubectl run --generator=run-pod/v1 -it --rm load-generator \
  --image=centos \
  --replicas=1 \
  --requests=cpu=100m,memory=256Mi \
  --limits=cpu=200m,memory=512Mi \
  --namespace=nitro```

curl -s 'https://demo.nginx.com/api/6/

https://docs.nginx.com/nginx/admin-guide/monitoring/live-activity-monitoring/#json_example

Add Load on the pod above - here bluenginx service is running on '172.20.77.241' ip
<br>
```
while true; do wget -q -O- 172.20.77.241; done
```

`docker run -ti --rm alpine/bombardier -c 200 -d 10s -l http://172.20.179.61`

`kubectl run -it --rm --image centos:centos7.6.1810 --restart=Never bluepod  -- curl -s http://nginx-svc`

```kubectl run --generator=run-pod/v1 -it --rm load-generator \
  --image=alpine/bombardier \
  --replicas=1 \
  --requests=cpu=100m,memory=256Mi \
  --limits=cpu=200m,memory=512Mi \
  --namespace=nitro```

```kubectl patch hpa  -p '{"spec":{"minReplicas":3}}'
```
<br>
Get a pods environment variables ( this might be the nodes env)
<br>
```
kubectl exec bluenginx-6ff7545748-6vkzc env
```
<br>
##### Trigger a redeploy in Kubernetes

**Sometimes you want to redeploy a service when a external change happens, but sadly there is no straight forward way to simply redeploy or rotate a deployment.**

**It can also be that you update a configmap and want to trigger a deployment of a service.**

**You can delete and reapply the service, but that would give you downtime.**

### Using kubectl patch

We can use `kubectl patch` to trigger a redeploy by for example adding a new label.

Here we have an example Kubernetes deployment of nginx:
<span class="colour" style="color:rgb(0, 0, 0)">Here we have an example Kubernetes deployment of nginx:</span>
<br>
```
apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
```

<span class="colour" style="color:rgb(0, 0, 0)">We can then force a redeploy by patching in a new label inside the spec->template->medata->labels.</span>
<br>
```
$ kubectl patch deployment your_deployment -p "{\"spec\": {\"template\": {\"metadata\": { \"labels\": {  \"redeploy\": \"$(date +%s)\"}}}}}"
```

<span class="colour" style="color:rgb(0, 0, 0)">And now you should see a new Replica</span>

<span class="colour" style="color:rgb(0, 0, 0)">Set trying to deploy new pods for you!</span>