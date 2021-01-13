kubectl apply -f k8s/namespaces/tarroja-namespace.yaml

kubectl config set-context tarroja --namespace=tarroja --user=minikube --cluster=minikube
kubectl config use-context tarroja

kubectl apply -f k8s/deployments/nginx-ingress.yaml

kubectl apply -f k8s/secrets/fc-client-env-secret.yaml
kubectl apply -f k8s/secrets/fc-api-env-secret.yaml
kubectl apply -f k8s/secrets/database-secret.yaml

kubectl apply -f k8s/pvs/mysql-pv.yaml

kubectl apply -f k8s/configmaps/php-fpm-configmap.yaml
kubectl apply -f k8s/configmaps/nginx-config-configmap.yaml

kubectl apply -f k8s/deployments/nginx-ingress.yaml
kubectl apply -f k8s/deployments/redis-deployment.yaml
kubectl apply -f k8s/deployments/mysql-deployment.yaml

kubectl apply -f k8s/deployments/fc-client.yaml
kubectl apply -f k8s/deployments/fc-api.yaml
kubectl apply -f k8s/deployments/fc-api-queue-worker.yaml

kubectl apply -f k8s/hpa/fc-api-hpa.yaml
kubectl apply -f k8s/hpa/fc-client-hpa.yaml

# kubectl apply -f k8s/ingress/mysql-ingress.yaml
# kubectl apply -f k8s/ingress/nginx-ingress-default-tarroja.yaml

kubectl apply -f k8s/services/redis-service.yaml
kubectl apply -f k8s/services/fc-api-service.yaml
kubectl apply -f k8s/services/fc-client-service.yaml

while [ true ]
do
    if kubectl rollout status deployment/mysql && \
        kubectl rollout status deployment/fc-api && \
        kubectl rollout status deployment/fc-client && \
        kubectl rollout status deployment/redis-master && \
        kubectl rollout status deployment/fc-api-queue-worker; then
        kubectl apply -f k8s/jobs/fc-api-migrate.yaml
        break
    fi
done

if kubectl wait --for=condition=complete job/fc-api-migrate; then
    minikube service fc-client -n tarroja
fi
