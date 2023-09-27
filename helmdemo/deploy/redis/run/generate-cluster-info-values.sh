#!/bin/bash

# Retrieve cluster information from the cluster-info ConfigMap in kube-public
#
# Output a values file that can be used to pass these values into Helm charts.
#

VALUES_FILE=environments/$1/cluster-info-values.yaml
echo $VALUES_FILE

kubectl get -n kube-public cm/cluster-info -ogo-template-file=run/cluster-info.gotemplate > $VALUES_FILE

cat $VALUES_FILE