### Create the dashboard service account

<a>https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md</a><a></a>
```kubectl apply -f dashboard-adminuser.yaml```

### Cluster Role Binding Account

```kubectl apply -f clusterrolebinding.yaml```

### Get to the Kubernetes Dashboard - First Run

```kubectl proxy```

### Then Get the bearer token

```kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')```

### Use the Token above in the hosted dashboard to get access to

<a></a>[kubernetes dashboard <link](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/storageclass?namespace=default)