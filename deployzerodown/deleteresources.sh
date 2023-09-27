kubectl delete deployment bluenginx
kubectl delete service nginx-svc 
kubectl delete horizontalpodautoscaler bluenginx 

kubectl delete deployment nginxhello
kubectl delete service nginxhello-svc 
kubectl delete horizontalpodautoscaler nginxhello 

kubectl run --generator=run-pod/v1 -it --rm load-generator \
  --image=busybox \
  --replicas=1 \
  --requests=cpu=100m,memory=256Mi \
  --limits=cpu=200m,memory=512Mi \
  --namespace=nitro

# pod disrupton budget
kubectl create pdb pdblesson1 -min-available 50% --selector "run=nginx"