helm template issue-6312-chart/ -f override-values.yaml

helm2 install --name dummy issue-6312-chart/ -f override-values.yaml

helm3 install dummy issue-6312-chart/ -f override-values.yaml