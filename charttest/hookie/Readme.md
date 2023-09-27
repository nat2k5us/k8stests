Hooks are a way to perform actions at varios points during the helm execution process
for example when
 - pre-install
 - post install

This is done via annotations

Annotations

pre-install | post-install | pre-delete| post-delete
---------|----------|---------|---------
 Executes after templates are rendered, but before any resources are created in <mark>Kubernetes</mark>  | Executes after all resources are loaded into <sub>K8s</sub>  | Executes on a deletion request before any resources are deleted from <sup>k8s</sup> | Executes on a deletion request after all resources after all resources have been deleted


  
 ### Hooks can be defined for Job, ConfigMap. Pod or Secrets.


## hooks are not managed by Kubernetes. i.e. these resources will not be deleted when a chart is deleted. They can be deleted using deletion policies
 - before-hook-creation | delete the resource before new hook is created
 - hook-succeeded | delete the resource after hook succeeded
 - hook-failed | delete the resource after hook failure

### for example
```
apiVersion: v1
 kind: Pod
 metadata:
   name: hook-preinstall
   annotations:
     "helm.sh/hook": "pre-install"
     “helm.sh/hook-delete-policy": before-hook-creation
```
in the above the resource will be deleted if it already exists. A single helm hook can create and delete multiple resources.
