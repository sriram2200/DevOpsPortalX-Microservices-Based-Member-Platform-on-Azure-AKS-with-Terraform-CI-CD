#  DevOpsPortalX – Microservices-Based Member Platform on Azure AKS with Terraform & CI/CD

## 📌 Project Overview

**DevOpsPortalX** is a **cloud-native, microservices-based Member Portal** built on **Azure Kubernetes Service (AKS)** using **Infrastructure as Code (Terraform)** and fully automated through **Azure DevOps CI/CD pipelines**.

The application follows a **three-tier architecture**:
-  presentation layer : **Node.js**
-  application layer: **Java (Maven)**
-  data layer: **PostgreSQL (RDBMS)**

This project showcases a real-world DevOps scenario with end-to-end automation, ingress configuration, monitoring, and containerized deployments — making it ideal for production-ready cloud environments.

##  Infrastructure Setup (Terraform)

###  Stage 1: Bootstrap
- Creates:
  - Resource Group
  - Storage Account & Blob Container
- Assigns SPN roles:
  - Owner (for RG)
  - Blob Data Contributor (for Storage Account)

```bash
cd infra/bootstrap
terraform init -backend=false
terraform apply
```

### Stage 2: Main Infrastructure
- Deploys:
  - AKS Cluster
  - ACR with pull permission for AKS
  - VNet and Subnet

```bash
cd infra/main
terraform init
terraform apply
```
### Stage 3: Ingress & Monitoring
- Deploys:
  - NGINX Ingress Controller deployed via Helm
  - Prometheus and Grafana via Helm
    
## CI/CD Pipeline (Azure DevOps)
- ### Infra Pipeline (infra-pipeline.yml)
  - Runs bootstrap and main Terraform stages
  - Uses remote backend for state management
- ### App Pipeline (app-pipeline.yml)
  - Build & Push:
    - NodeJS frontend Docker image → ACR
    - Java backend Docker image → ACR
 - Deploy:
  - PostgreSQL StatefulSet with PVC
  - Frontend & Backend deployments
  - Ingress setup using NGINX controller
    
## Monitoring Stack
- Deployed Terraform module
- Tools:
  - Prometheus: Metrics scraping from AKS
  - Grafana: Visualization dashboards
  - Pipeline-triggered deployment, fully automated
 
## Architecture

![Arch](https://github.com/user-attachments/assets/fa5df1c7-6cbb-468d-af71-d023b0c4540c)

