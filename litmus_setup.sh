
kubectl create ns litmus
kubectl apply -f https://raw.githubusercontent.com/litmuschaos/litmus/master/chaoscenter/manifests/litmus-portal-crds.yml -n litmus
kubectl apply -f https://raw.githubusercontent.com/litmuschaos/litmus/master/mkdocs/docs/3.0.0-beta6/litmus-namespaced-3.0.0-beta6.yaml -n litmus
kubectl set env deployment/litmusportal-server -n litmus --containers="graphql-server" CHAOS_CENTER_UI_ENDPOINT="http://172.132.44.44:3231"
nohup kubectl port-forward --address localhost,192.168.31.229 service/litmusportal-frontend-service 9091:9091 -n litmus &

kubectl get pod -n litmus
