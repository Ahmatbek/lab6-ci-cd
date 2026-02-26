# DevOps Infrastructure Project
## How to Run
1. Build: `docker build -t app ./infrastructure/docker/`
2. Infra: `cd infrastructure/terraform && terraform init`
3. K8s: `kubectl apply -f infrastructure/kubernetes/`
Plan A for deployment
