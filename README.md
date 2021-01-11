# Running an instance of Forecasts App

## Requirements
- `docker`
- `minikube`
- `kubectl`

## Installation
1. Get the `minikube` IP:
   ```bash
   minikube ip
   ```
1. Add the ff. entry to your hosts file:
   ```bash
   <YOUR_MINIKUBE_IP> fc-api.test
   ```
1. ```bash
   git clone https://github.com/juanitotrrj/fc-devops.git
   ```
1. ```bash
   cd fc-devops
   ```
1. ```bash
   bash install.sh
   ```

## Viewing fc-api API Explorer
```bash
minikube service fc-client -n tarroja
```
