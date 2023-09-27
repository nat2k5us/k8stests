cat /etc/kubernetes/manifets | grep file

ETCDCTL_API=3 etcdctl --endpoints 127.0.0.1:2379 snapshot save /opt/etcd-backup.db \
--cacert=/etc/kubernetes/pki/etcd/ca.crt
--cert=/etc/kubernetes/etcd/server.crt
--key=/etc/kubernetes/etcd/key.crt

in root/CKA/john.key and john.csr are present
>> cat john.csr shows Certificate Request Hash

1. Firstly we have to create a Certificate Signing Request and get it approved.

2. Create a Role and Role Binding 

- vi john-csr.yaml # replace key with johns key in file
- the key in file is not base64 encoded so encode it using
   >> cat john.csr | base64 | tr -d "\n"
   copy the base64 encoded key to the file john-csr.yaml 
   and save the file 

   ```yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: john-developer
spec:
  request: <base64 encoded key>
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400 
  usages:
  - client auth
  ```


$> k create -f josh-csr.yaml
$> k certificate approve john-developer
$> k get csr # john-developer should be present

$> k create role developer --verb=create,get,list --resource=pods -n development
$> k get role -n development

$> k auth can-i get pods -n developement --as john 
### response is no - will turn to yes once role binding is made

$> k create rolebinding john-developer --role=developer --user=john -n developer

$> k get rolebinding -n developer

$> 