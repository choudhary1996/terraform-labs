# 📘 EC2 Instance Creation with Terraform

This documentation explains how to create an AWS EC2 instance using Terraform. It is designed as a simple lab exercise to help you understand the basics of Infrastructure as Code (IaC) using Terraform.

---

## 📋 Prerequisites

Ensure you have the following installed and configured:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed on your local machine.
- An AWS Account.
- SSO login configured or AWS credentials exported manually.

### 🔑 AWS SSO Login (Preferred)

Run the following to configure SSO:
aws configure sso
## 🔑 Export AWS Credentials (Manual Method)
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
export AWS_REGION="your-region" # e.g., us-east-1
🧰 Usage Instructions:
1. Clone the Repository: git clone <repo>
2. Initialize Terraform: terraform init
3.  Format the Terraform File: terraform fmt
4. Review the Plan: terraform plan
5. Apply the Configuration: terraform apply
6. Destroy the Infrastructure (To Avoid Charges): terraform destroy

💡 Best Practices
git status
git add .
git commit -m "Initial EC2 setup"
git push
