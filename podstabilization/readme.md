kubeadm config is present in the kube-system

![kubeadmin](../images/kubeadm.png)

Added the extrArgs section - to increase pod stabilization

![kubeadmin](../images/kubeadm2.png)

### patch to increase min replicas

```kubectl patch hpa php-apache --patch '{"spec":{"minReplicas":3}}'```

### patch to increase min replicas

```kubectl patch hpa php-apache --patch '{"spec":{"minReplicas":15}}'```