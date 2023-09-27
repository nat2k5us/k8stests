#### Create a deployment with 4 nginx replicas

```kubectl run nginx --image nginx --replicas 4```

#### create the pdb

```kubectl create pdb pdbtest --min-available 50% --selector "app=pdb-nginx"```

#### kubectl drain

##### **How Disruption Budgets Work**

***An Application Owner can create a PodDisruptionBudget object (PDB) for each application. A PDB limits the number of pods of a replicated application that are down simultaneously from voluntary disruptions. For example, a quorum-based application would like to ensure that the number of replicas running is never brought below the number needed for a quorum. A web front end might want to ensure that the number of replicas serving load never falls below a certain percentage of the total.***

***Cluster managers and hosting providers should use tools which respect Pod Disruption Budgets by calling the Eviction API instead of directly deleting pods or deployments. Examples are the kubectl drain command and the Kubernetes-on-GCE cluster upgrade script (cluster/gce/upgrade.sh).***

***When a cluster administrator wants to drain a node they use the `kubectl drain command`. That tool tries to evict all the pods on the machine. The eviction request may be temporarily rejected, and the tool periodically retries all failed requests until all pods are terminated, or until a configurable timeout is reached.***

***A PDB specifies the number of replicas that an application can tolerate having, relative to how many it is intended to have. For example, a Deployment which has a .spec.replicas: 5 is supposed to have 5 pods at any given time. If its PDB allows for there to be 4 at a time, then the Eviction API will allow voluntary disruption of one, but not two pods, at a time.***

***The group of pods that comprise the application is specified using a label selector, the same as the one used by the application’s controller (deployment, stateful-set, etc).***

***The “intended” number of pods is computed from the .spec.replicas of the pods controller. The controller is discovered from the pods using the .metadata.ownerReferences of the object.***

***PDBs cannot prevent involuntary disruptions from occurring, but they do count against the budget.***

***Pods which are deleted or unavailable due to a rolling upgrade to an application do count against the disruption budget, but controllers (like deployment and stateful-set) are not limited by PDBs when doing rolling upgrades – the handling of failures during application updates is configured in the controller spec. (Learn about updating a deployment.)***

***When a pod is evicted using the eviction API, it is gracefully terminated (see terminationGracePeriodSeconds in PodSpec.)***