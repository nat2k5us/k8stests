### Two containers 

#### The (container 2) shell make a curl call to the sise (Conatiner 1) by
1. login into a interactive shell of container 2

```kubectl exec twocontainers -c shell -i -t -- bash```

2.  Make a curl request from the interactive shell

 ```curl -s localhost:9876/info```

### deployment.yaml
```yml
apiVersion: v1
kind: Pod
metadata:
  name: twocontainers
spec:
  containers:
    - name: sise
      image: mhausenblas/simpleservice:0.5.0
      ports:
        - containerPort: 9876
    - name: shell
      image: centos:7
      command:
        - "bin/bash"
        - "-c"
        - "sleep 10000"

```
