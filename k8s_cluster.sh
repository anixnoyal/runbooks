
systemctl disable firewalld
systemctl stop firewalld
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

##############################  k3s ##############################
curl -sfL https://get.k3s.io | sh -s - server \
  --bind-address $(hostname -I) \
  --advertise-address $(hostname -I)

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

#setup proxy
vi /etc/systemd/system/k3s.service
Environment="HTTP_PROXY=http://your-proxy-server:port"
Environment="HTTPS_PROXY=https://your-proxy-server:port"
Environment="NO_PROXY=localhost,127.0.0.1"
systemctl daemon-reload
systemctl restart k3s

#dns issue
kubectl get pods -n kube-system | grep coredns
kubectl logs -n kube-system <coredns-pod-name>
kubectl describe configmap coredns -n kube-system

#restart coredns
kubectl rollout restart deployment coredns -n kube-system
#check dns
kubectl run -it --rm --restart=Never busybox --image=busybox sh
# Inside the container run:
nslookup kubernetes.default


#backup 
kubectl get configmap coredns -n kube-system -o yaml > coredns-config-backup.yaml
kubectl edit configmap coredns -n kube-system
kubectl delete pods -n kube-system -l k8s-app=kube-dns


##############################  kind ##############################
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.11.1/kind-$(uname)-amd64"
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

cat > jenkins-config.yaml <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  apiServerAddress: "192.168.31.229" # your_vm_ip
  apiServerPort: 58350
EOF

kind create cluster --config jenkins-config.yaml
#kind delete cluster


##############################  minikube ##############################

#https://www.linuxtechi.com/install-minikube-on-rhel-rockylinux-almalinux/
#https://stackoverflow.com/questions/47173463/how-to-access-local-kubernetes-minikube-dashboard-remotely/54960906#54960906

# docker
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf repolist
dnf install docker-ce docker-ce-cli containerd.io -y

usermod -aG docker $USER
newgrp docker
systemctl enable --now docker

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
kubectl version --client

# minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
rpm -ivh minikube-latest.x86_64.rpm

minikube start --driver=docker  --force

minikube status
minikube ip

kubectl cluster-info
kubectl get nodes

# test app
kubectl create deployment test-minikube --image=k8s.gcr.io/echoserver:1.10
kubectl expose deployment test-minikube --type=NodePort --port=8080
kubectl get deployment,pods,svc
minikube service test-minikube --url
curl $from_above_url
minikube addons list
minikube addons enable dashboard
minikube addons enable ingress
#kubectl proxy –address=’0.0.0.0′ –disable-filter=true
minikube dashboard --url

## minikube config reset
minikube stop
minikube delete
docker system prune -a
systemctl stop docker

##############################  k8s cluster status ##############################
kubectl cluster-info 
kubectl get nodes -o wide
kubectl get all --namespace=kube-system
