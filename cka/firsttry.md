# CKA Exam Notes - First Attempt
```html
<!-- Cache Contents -->

ssh mk8s-master-0
kubectl config use-context mk8s
ssh wk8s-node-0
kubectl config use-context k8s

kubectl config use-context ok8s
curl -kL <INTERNAL_IP>/hi
volumeMounts:
    - name: secret-volume
      readOnly: true
      mountPath: "/etc/secret-volume"
```
Had Total of 17 questions which I was able to complete quickly with 25 minutes to spare. While holding of the below 4 questions. This is why this exam is tough - Assuming all the straight-forward simple questions were answered correctly and the 4 questions were not scored or given any score by the auto scoring 13% + 7% + 7% + 7% = 34%
You end up with 66% - so any minor mistakes in assumptions that you are right will backfire and put you in failure.

Notes for future: If things are expressed in BOLD - pay extra attention - like the INTERNAL_IP
Draining Nodes, Troubleshooting Problems should be memorized or practiced multiple times
This time these was no network policy question


4%: pod hi connected to service - finally saying - change to service being nodeport and then try to get a response on cur l -kL <INTERNAL_IP>/hi
4%:  pod hello connected to service - finally saying - change to service being nodeport and then try to get a response on curl -kL <INTERNAL_IP>/hello - did not work - tried nslookup, kt - curl, ping - got error about docker entry point
what is the INTERNAL_IP? The instance internal IP address will be used to advertise the API Server to members of the cluster. Retrieve the internal IP address for the current compute instance:
IP confusion: INTERNAL_IP, EXTERNAL_IP, CLUSTER_IP, NODE_IP
getting the internal ip
INTERNAL_IP=$(ip addr show enp0s8 | grep "inet " | awk '{print $2}' | cut -d / -f 1)
4%: get nodes that are not tainted and save the count to a location - I used the k describe no | grep Taints -C4 to count and write out the number manually
`kubectl get nodes -o jsonpath="{range .items[*]}{.metadata.name} {.spec.taints[?(@.effect=='NoSchedule')].effect}{\"\n\"}{end}"`

7% Q: 11-factor-app add sidecar busybox called sidecar that logs 
"/bin/sh -c "tail -n+1 -f /var/log/11-factor-app.log"
The sidecar container does not start and stuck in CrashLoopBackoff
I added a volume EmptyDir: {}

Q: Add Side Car to running pod : /bin/sh -c "tail -n+1 -f /var/log/big-corp-app.log"

Network Policy: there are two namespaces - they don't exist in the system - when I tried `k get ns -A --show-labels`
the namespaces were `echo` and `my-app` - how will you prevent outgoing from echo to my-app

4% Q: Backup and Restore Etcd
ETCDCTL_API=3 etcdctl snapshot save \
    --cacert /etc/kubernetes/pki/etcd/ca.crt \
    --cert /etc/kubernetes/pki/etcd/server.crt \
    --key /etc/kubernetes/pki/etcd/server.key \
    /opt/snapshot-pre-boot.db

Restore:
1. ETCDCTL_API=3 etcdctl snapshot restore \
    --data-dir /var/lib/etcd-from-backup \
    /opt/snapshot-pre-boot.db
2. Now do the following on the control node.

Edit the manifest file for etcd on the controlplane node. This is found in
"/etc/kubernetes/manifests/etcd.yaml"
Scroll down to the volumes section and find the volume that describes the data directory (see below).
Edit the hostPath.path of the volume with name etcd-data from "/var/lib/etcd" to /var/lib/etcd-from-backup (or whichever directory you used for the restore command - see --data-dir above - needs to match it). 
  volumes:
  - hostPath:
      path: /etc/kubernetes/pki/etcd
      type: DirectoryOrCreate
    name: etcd-certs
  - hostPath:
      path: /var/lib/etcd    # <- change this
      type: DirectoryOrCreate
    name: etcd-data
Wait about a minute for everything to reload.


7% Q: Upgrade master node after draining to 1.25.2 from 1.25.1 - this I was able to do using the commands 

13% Q: weight - One node is not ready - debugging showed errors on the kubelet but can't figure out what was wrong
crictl showed only fannel and one more service running
Could not locate the etcd or manifests location
2nd: Looked like the same question - `k get no` showed two nodes 0f which one was not ready 
-- ssh into problem node
-- kublet was not running when I ran `systemctl status kubelet`
-- I issued the command `systemctl restart kubelet`
-- the kubelet started and the node was ready - so I think it was done - kinda felt it was a simple fix

4%: Deployment with SA and role bound to serviceaccount - no talk about creating a rolebinding to SA - I just did that anyways

4%: Get the count of nodes that are set to :NoSchedule - only master was having that as Taint - there were a total of three nodes

?%: Patch or Edit deployment/svc  

?%: update the given yaml to the latest by removing deprecations

## Questions others posted they had in exam:
```html
q: How to make a curl call using certs 
Perhaps if scenario involves using secret in a pod, that will give you a TOKEN.
$k describe po <pod name>
look for the mount path
$k exec <pod> -it -- sh
TOKEN=$(cat <mounth path from pod>/token)
curl -k <https://kubernets url to api resources>/api --header "Authorization: Bearer $TOKEN" --insecure
```