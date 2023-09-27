### Install the helm chart into local kubernetes
```helm install -n=swagger-dd swagger-chart```

### Delete the installed chart
```helm delete swagger-dd```

### remove the installed chart fully
```helm ls --all --short | xargs -L1 helm delete --purge```

### navigate the deployed swagger docs
``` localhost:8080```

### create config map from swagger.yaml
```kubectl create configmap configmap-swagger --from-file=./swagger.yaml```

```kubectl create configmap swagger-configmap --from-file=../startyaml/swagger.yaml```
