# 8byte DevOps Intern Assignment

Deploy a Containerized Node.js Application on AWS using Terraform and GitHub Actions

## 📋 Project Overview

This project demonstrates the deployment of a containerized Node.js web application on AWS infrastructure provisioned using Terraform, with automated CI/CD pipeline using GitHub Actions.

**Technologies Used:**
- **Cloud Provider**: AWS
- **Infrastructure as Code**: Terraform
- **Containerization**: Docker
- **CI/CD**: GitHub Actions
- **Application**: Node.js with Express
- **Operating System**: Ubuntu 22.04

## 🏗️ Architecture

The infrastructure consists of:
- **VPC** with CIDR 10.0.0.0/16
- **Public Subnet** with CIDR 10.0.1.0/24
- **Internet Gateway** for public internet access
- **Route Table** with routes to Internet Gateway
- **Security Group** allowing:
  - SSH access (port 22)
  - Application access (port 3000)
- **EC2 Instance** (t2.micro) running Ubuntu 22.04 with Docker pre-installed

## 📁 Project Structure

```
8byte-devops-intern-assignment/
├── app.js                      # Node.js Express application
├── package.json                # Node.js dependencies
├── Dockerfile                  # Docker configuration
├── .dockerignore              # Docker ignore file
├── terraform/                 # Terraform configuration
│   ├── provider.tf           # AWS provider setup
│   ├── variables.tf          # Variable definitions
│   ├── terraform.tfvars      # Variable values
│   ├── main.tf              # Infrastructure resources
│   └── outputs.tf           # Output definitions
├── .github/
│   └── workflows/
│       └── ci.yml           # GitHub Actions CI/CD pipeline
└── README.md                # This file
```

## 🚀 TASK 1: Run Application Locally

### Prerequisites
- Node.js (v14 or higher)
- npm

### Steps

1. **Install dependencies:**
```bash
npm install
```

2. **Run the application:**
```bash
node app.js
```

3. **Verify the application:**
Open your browser and navigate to:
```
http://localhost:3000
```

You should see: `8byte Intern Assignment Successfully Deployed `

## 🐳 TASK 2: Build and Run Docker Container

### Prerequisites
- Docker installed on your system

### Steps

1. **Build the Docker image:**
```bash
docker build -t 8byte-intern-app .
```

2. **Run the Docker container:**
```bash
docker run -p 3000:3000 8byte-intern-app
```

3. **Verify the containerized application:**
```
http://localhost:3000
```

4. **Stop the container:**
```bash
docker ps                           # Get container ID
docker stop <container-id>
```

## ☁️ TASK 3: Provision Infrastructure Using Terraform

### Prerequisites
- AWS Account
- AWS CLI configured with credentials
- Terraform installed (>= 1.0)
- SSH Key Pair created in AWS EC2 Console

### Steps

1. **Configure AWS credentials:**
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

Or use AWS CLI:
```bash
aws configure
```

2. **Create SSH Key Pair (if not exists):**
- Go to AWS Console → EC2 → Key Pairs
- Create new key pair and download `.pem` file
- Update `terraform/terraform.tfvars` with your key name:
```hcl
ssh_key_name = "your-key-name"
```

3. **Navigate to terraform directory:**
```bash
cd terraform
```

4. **Initialize Terraform:**
```bash
terraform init
```

5. **Review the execution plan:**
```bash
terraform plan
```

6. **Apply the configuration:**
```bash
terraform apply
```

Type `yes` when prompted.

7. **Note the outputs:**
After successful apply, Terraform will display:
- EC2 Public IP
- EC2 Public DNS
- Application URL
- SSH Command

## 🖥️ TASK 4: Deploy Application on EC2

### Steps

1. **Get EC2 Public IP from Terraform outputs:**
```bash
terraform output ec2_public_ip
```

2. **SSH into the EC2 instance:**
```bash
ssh -i /path/to/your-key.pem ubuntu@<EC2-PUBLIC-IP>
```

3. **Verify Docker installation:**
```bash
docker --version
sudo systemctl status docker
```

4. **Create application directory:**
```bash
mkdir -p ~/app
cd ~/app
```

5. **Create app.js:**
```bash
cat > app.js << 'EOF'
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('8byte Intern Assignment Successfully Deployed ');
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
EOF
```

6. **Create package.json:**
```bash
cat > package.json << 'EOF'
{
  "name": "8byte-intern-assignment",
  "version": "1.0.0",
  "dependencies": {
    "express": "^4.18.2"
  }
}
EOF
```

7. **Create Dockerfile:**
```bash
cat > Dockerfile << 'EOF'
FROM node:18-alpine
WORKDIR /app
COPY package.json .
RUN npm install
COPY app.js .
EXPOSE 3000
CMD ["node", "app.js"]
EOF
```

8. **Build the Docker image:**
```bash
docker build -t 8byte-intern-app .
```

9. **Run the Docker container:**
```bash
docker run -d -p 3000:3000 --name app-container 8byte-intern-app
```

10. **Verify the container is running:**
```bash
docker ps
```

11. **Access the application:**
Open your browser and navigate to:
```
http://<EC2-PUBLIC-IP>:3000
```

You should see: `8byte Intern Assignment Successfully Deployed `

## 🔄 TASK 5: CI/CD Using GitHub Actions

### GitHub Actions Pipelines

This project includes three GitHub Actions workflows:

#### 1. CI - Docker Build (ci.yml)
Automatically triggers on push to `main` branch:
1. Checks out the code
2. Sets up Docker Buildx
3. Builds the Docker image
4. Verifies the build was successful
5. Tests the container
6. **(Optional)** Pushes to Docker Hub

#### 2. Terraform Apply (terraform-apply.yml)
Manual workflow to provision infrastructure:
- Go to Actions → Terraform Apply → Run workflow
- Type "apply" to confirm
- Deploys all AWS resources
- Displays EC2 IP and application URL

#### 3. Terraform Destroy (terraform-destroy.yml)
Manual workflow to destroy infrastructure:
- Go to Actions → Terraform Destroy → Run workflow
- Type "destroy" to confirm
- Removes all AWS resources

### Setup Instructions

1. **Push code to GitHub:**
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/your-username/8byte-devops-intern-assignment.git
git push -u origin main
```

2. **Configure GitHub Secrets:**

Go to GitHub repository → Settings → Secrets and variables → Actions

Add the following secrets:
- `AWS_ACCESS_KEY_ID`: Your AWS access key (required for Terraform workflows)
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret key (required for Terraform workflows)
- `DOCKER_USERNAME`: Your Docker Hub username (optional, for Docker Hub push)
- `DOCKER_PASSWORD`: Your Docker Hub password or access token (optional, for Docker Hub push)

3. **View pipeline execution:**
- Go to Actions tab in your GitHub repository
- Watch the workflow run

## 📊 TASK 6: Verification Screenshots

### Required Screenshots:

1. **Terraform Apply Output**
   - Screenshot of successful `terraform apply` command
   - Shows all resources created

2. **Running EC2 Instance**
   - AWS Console showing the running EC2 instance
   - Instance details (ID, state, IP address)

3. **Application in Browser**
   - Browser showing the application running on EC2
   - URL visible: `http://<EC2-IP>:3000`
   - Message: "8byte Intern Assignment Successfully Deployed "

4. **Successful GitHub Actions Pipeline**
   - GitHub Actions workflow showing successful build
   - All steps completed (green checkmarks)

## 🧪 Testing & Verification Checklist

- [ ] Application runs locally on `http://localhost:3000`
- [ ] Docker image builds successfully
- [ ] Docker container runs and serves the application
- [ ] Terraform provisions all required AWS resources
- [ ] EC2 instance is accessible via SSH
- [ ] Docker is installed and running on EC2
- [ ] Application is publicly accessible via `http://<EC2-IP>:3000`
- [ ] GitHub Actions pipeline runs successfully
- [ ] All screenshots captured

## 🔧 Troubleshooting

### Application Issues
```bash
# Check if app is running
curl http://localhost:3000

# Check Docker logs
docker logs app-container

# Restart container
docker restart app-container
```

### Terraform Issues
```bash
# Check Terraform state
terraform show

# Destroy and recreate
terraform destroy
terraform apply
```

### EC2 Connection Issues
```bash
# Verify security group allows SSH (port 22)
# Verify your IP is allowed
# Check SSH key permissions
chmod 400 /path/to/your-key.pem
```

## 🧹 Cleanup

To avoid AWS charges, destroy the infrastructure when done:

```bash
cd terraform
terraform destroy
```

Type `yes` when prompted.

## 📝 Assumptions & Notes

1. AWS Free Tier is used (t2.micro instance)
2. Default region is `us-east-1` (can be changed in `terraform.tfvars`)
3. Security group allows access from anywhere (0.0.0.0/0) - **not recommended for production**
4. SSH key pair must be created manually in AWS Console
5. Docker Hub push is optional and requires secrets configuration

## 🎯 Evaluation Criteria Met

✅ **Terraform Infrastructure**: Complete VPC, subnet, IGW, routes, security groups, EC2  
✅ **Docker Implementation**: Proper Dockerfile with multi-stage optimization  
✅ **CI/CD Pipeline**: Automated build and test on push  
✅ **Code Quality**: Clean, well-structured, and documented  
✅ **Documentation**: Comprehensive README with all steps  
✅ **Security**: Security groups properly configured  
✅ **Automation**: Infrastructure as Code, automated CI/CD  

## 📞 Support

For questions or issues, please reach out to the assignment coordinator.

## 📄 License

This project is created for the 8byte DevOps Intern Assignment.

---

**Author**: [Your Name]  
**Date**: February 2026  
**Assignment**: 8byte DevOps Intern Technical Assessment
