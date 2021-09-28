#echo "Install EKS cli "
#curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
#sudo mv /tmp/eksctl /usr/local/bin
#echo "eksctl version"
#eksctl version
#exit
echo "Create Cluster using eks "
#eksctl create nodegroup  --config-file=eks-config.yaml 
eksctl create cluster -f eks-config.yml
AWS_REGION=us-west-2
AWS_ACCOUNT_ID=XXXX

echo "Locally output is minikube"
echo "Change configuration to my aws account"

#kubectl config use-context arn:aws:eks:${AWS_REGION}:${AWS_ACCOUNT_ID}:cluster/d4c-cluster
kubectl config current-context

echo "Deploy Blue"
kubectl apply -f ./blue.yml
kubectl describe replicationcontrollers
kubectl describe services bluegreenlb
echo "Deploy green"
kubectl apply -f ./green.yml
kubectl describe replicationcontrollers
kubectl describe services bluegreenlb


echo "Delete cluster"
kubectl get svc --all-namespaces
kubectl delete svc bluegreenlb
eksctl delete cluster --name d4c-cluster
