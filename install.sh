minikube start

# prepare the namespace
kubectl config set-context tarroja --namespace=tarroja --user=minikube --cluster=minikube
kubectl config use-context tarroja

# install an instance of ingress-nginx
kubectl apply -f k8s/deployments/nginx-ingress.yaml
