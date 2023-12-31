
Q:
Upgrade the current version of kubernetes from 1.23.0 to 1.24.0 exactly using the kubeadm utility. Make sure that the upgrade is carried out one node at a time starting with the controlplane node. To minimize downtime, the deployment gold-nginx should be rescheduled on an alternate node before upgrading each node.

Upgrade controlplane node first and drain node node01 before upgrading it. Pods for gold-nginx should run on the controlplane node subsequently.

Solution
Here is the solution for this task. Please note that the output of these commands have not been added here.

On the controlplane node:

root@controlplane:~# kubectl drain controlplane --ignore-daemonsets
root@controlplane:~# apt update
root@controlplane:~# apt-get install kubeadm=1.24.0-00
root@controlplane:~# kubeadm upgrade plan v1.24.0
root@controlplane:~# kubeadm upgrade apply v1.24.0
root@controlplane:~# apt-get install kubelet=1.24.0-00
root@controlplane:~# systemctl daemon-reload
root@controlplane:~# systemctl restart kubelet
root@controlplane:~# kubectl uncordon controlplane

Before draining node01, we need to remove the taint from the controlplane node.

# Identify the taint first. 
root@controlplane:~# kubectl describe node controlplane | grep -i taint

# Remove the taint with help of "kubectl taint" command.
root@controlplane:~# kubectl taint node controlplane node-role.kubernetes.io/control-plane:NoSchedule-

# Verify it, the taint has been removed successfully.  
root@controlplane:~# kubectl describe node controlplane | grep -i taint

Now, drain the node01 as follows: -
root@controlplane:~# kubectl drain node01 --ignore-daemonsets
 ssh ßto the node01 and perform the below steps as follows:
 root@node01:~# apt update
root@node01:~# apt-get install kubeadm=1.24.0-00
root@node01:~# kubeadm upgrade node
root@node01:~# apt-get install kubelet=1.24.0-00
root@node01:~# systemctl daemon-reload
root@node01:~# systemctl restart kubelet

To exit from the specific node, type exit or logout on the terminal.

Back on the controlplane node:

root@controlplane:~# kubectl uncordon node01
root@controlplane:~# kubectl get pods -o wide | grep gold (make sure this is scheduled on node)