# IaC Automation Framework (Demo)

This project demonstrates an **Infrastructure as Code (IaC) Automation Framework** using **Terraform**, **Docker**, **Jenkins**, and security scanning tools (**tfsec** and **Checkov**). The setup pulls an Nginx Docker image, runs it as a container, and provides CI/CD integration through Jenkins.

---

## Tools Used
- **Terraform** – Infrastructure provisioning.
- **Docker** – Containerization.
- **Jenkins** – CI/CD automation.
- **tfsec** – Terraform security scanning.
- **Checkov** – Infrastructure-as-Code security scanning/compliance

---

## Directory Structure
```
sruthi-3-0-cap_project/
├── README.md
├── Jenkinsfile
├── main.tf
├── outputs.tf
└── variables.tf
```

---

## Prerequisites
1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop).
2. Install [Terraform](https://developer.hashicorp.com/terraform/downloads).
3. Install [Jenkins](https://www.jenkins.io/download/).
4. Ensure your system has **Git** installed.

---

## Steps to Run Locally

### 1. Clone the Repository
```bash
git clone https://github.com/Sruthi-3-0/Cap_Project.git
cd Cap_Project
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Apply Terraform Configuration
```bash
terraform apply -auto-approve
```
This will:
- Pull the `nginx:latest` Docker image.
- Run a container named `nginx_demo` (default) or `nginx_container` based on your Terraform configuration.
- Map internal port `80` to external port `8081` (or as specified in `variables.tf`).

### 4. Access Nginx
Open a browser and navigate to:
```
http://localhost:8081
```

---

## Jenkins CI/CD Pipeline

The Jenkinsfile includes the following stages:

1. **Checkout Code**  
   Pulls the latest code from the GitHub repository.

2. **Terraform Init & Apply**  
   Initializes Terraform and applies the configuration automatically.

3. **Security Scan - tfsec**  
   Runs **tfsec** in a Docker container to check Terraform security issues.

4. **Security Scan - Checkov**  
   Runs **Checkov** in a Docker container for additional security scanning.

5. **Verify Docker Image Running**  
   Lists running Docker containers to verify Nginx is active.

### Run Jenkins Pipeline
1. Open Jenkins.
2. Create a new pipeline project.
3. Set the pipeline to use the **Jenkinsfile** from this repo.
4. Add GitHub credentials (`github-creds`) in Jenkins.
5. Run the pipeline.

---

## Terraform Variables

- `container_name` – Name of the Docker container (default: `nginx_demo`).
- `external_port` – Port to access Nginx (default: `8081`).

You can override these variables in `terraform apply`:
```bash
terraform apply -var="container_name=my_nginx" -var="external_port=9090" -auto-approve
```

---

## Security Scans

- **tfsec:** `docker run --rm -v $PWD:/src aquasec/tfsec /src`
- **Checkov:** `docker run --rm -v $PWD:/src bridgecrew/checkov --directory /src`

Both ensure your IaC configurations follow best security practices.

---

## Verify Docker Container
```bash
docker ps
```
You should see a container running `nginx:latest` with the mapped port.

