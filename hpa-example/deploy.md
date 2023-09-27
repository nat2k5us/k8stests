## HPA autoscaler
### [HPA Demo] 
[HPA Walking Link](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)  
[Unofficial walkthrough](https://unofficial-kubernetes.readthedocs.io/en/latest/tasks/run-application/horizontal-pod-autoscale-walkthrough/)

### Create the Pod from image 
```kubectl run php-apache --image=gcr.io/google_containers/hpa-example --requests=cpu=200m --expose --port=8011```
### scale the hpa higher
```kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10```

### We may check the current status of auto scaler by running

```kubectl get hpa```

### Increase load

Now, we will see how the autoscaler reacts to increased load. We will start a container, and send an infinite loop of queries to the php-apache service (please run it in a different terminal):

```kubectl run --generator=run-pod/v1 -it --rm load-generator --image=busybox /bin/sh```

Hit enter for command prompt

below code runs a while loop to load the pod and increase CPU usage

`while true; do wget -q -O- http://php-apache.default.svc.cluster.local; done`


### Check metrics
`kubectl get --raw /apis/metrics.k8s.io/v1beta1`

Error from server (NotFound): the server could not find the requested resource

I don't have a metrics server installed - install from here
[metrics server](https://github.com/kubernetes-sigs/metrics-server)  

Enabling Metrics Server in Docker Desktop
1. Clone or download the Metrics Server project.

2. Open the deploy/kubernetes/metrics-server-deployment.yaml file in an editor.

3. Add the –kubelet-insecure-tls argument into the existing args section. That section will look like the following once you're done:

args:                                    
```                                      
  - --cert-dir=/tmp                      
  - --secure-port=4443                   
  - --kubelet-insecure-tls                                 
```                                                        
NOTE: DO NOT enable kubelet-insecure-tls on a cluster that will be accessed externally. This is only being done for a local Docker Desktop cluster.
                                                           
4. Run the following command as shown on the Metrics Server repo to create the deployment, services, etc.
                                                           
```kubectl create -f deploy/kubernetes```                  
                                                           
5. To see how things are going, first get the name of your Metrics Server Pod by running the following command:
                                                           
```kubectl get pods -n kube-system```                      
                                                           
6. Now run the following command and the logs should show it starting up and the API being exposed successfully:
                                                           
```kubectl logs [metrics-server-pod-name] -n kube-system```
                                                           
7. Give it a little time and you should now be able to run kubectl top commands!
                                                           
                                                           
![lab1](https://github.com/nat2k5us/k8tests/blob/master/k8stests/images/metrics1.png "lab 1")
![lab2](https://github.com/nat2k5us/k8tests/blob/master/k8stests/images/metrics2.png "lab 2")
![lab2](https://github.com/nat2k5us/k8tests/blob/master/k8stests/images/metrics3.png "lab 3")