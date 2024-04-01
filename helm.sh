
# install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Litmus ChaosCenter
helm search repo litmuschaos
helm install chaos litmuschaos/litmus --namespace litmus --debug

## uninstall helm
helm list --all-namespaces
helm uninstall chaos-center -n litmus
helm uninstall chaos-core -n litmus
