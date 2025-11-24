
# 📘 GitHub Actions Playground — Terraform CI/CD Demo

This repository serves as a **practice environment for learning GitHub Actions** and integrating them with **Terraform automation**.
It demonstrates how AWS infrastructure can be deployed automatically using a CI/CD pipeline.

This project is ideal for anyone who wants to understand:

* How Terraform works inside GitHub Actions
* How to securely manage state using S3 backend
* How to set up inputs (plan/apply/destroy) in workflows
* How to structure a simple infrastructure-as-code project


## 🏗️ Terraform Project Structure

Your project contains three main Terraform files. Below is a simple and clear explanation of what each one does:

### **1️⃣ backend.tf — Remote State Storage**

This file configures Terraform to store its state file in an **S3 bucket** instead of locally.

Inside this file you define:

* The name of the S3 bucket used for storing state
* The exact path/key where the state will be stored
* The AWS region of the bucket

Using a remote backend ensures:

* Your GitHub Action workflow can access state
* State is consistent across machines
* You avoid accidental overwrites or lost state


### **2️⃣ providers.tf — AWS Provider Configuration**

This file tells Terraform **which cloud provider you are using** and which region your resources should be created in.

Inside this file you set:

* AWS as the provider
* The default region where Terraform should deploy all resources

This acts as the “entry point” for Terraform to know how to communicate with AWS.


### **3️⃣ main.tf — Infrastructure Definition**

This is the file where your **actual AWS resources** are declared.

It contains:

* A VPC with a fixed CIDR block
* A public subnet inside a specific availability zone
* An EC2 instance (where you must later specify a valid AMI ID)

This is the core infrastructure that your GitHub Actions workflow will plan, apply, and destroy.


## ⚙️ GitHub Actions Workflow (High-Level Overview)

Your workflow is designed to let users choose different actions when triggering the pipeline.
The supported actions are:

* **Plan** → Shows what changes Terraform will make
* **Apply** → Deploys the infrastructure
* **Destroy** → Removes everything created

The workflow performs steps in this order:

1. Checks out the repository
2. Configures AWS credentials (from GitHub Secrets)
3. Installs Terraform
4. Runs init, validate, plan
5. Applies or destroys based on your choice

This makes it a fully interactive Terraform pipeline.


## 🔐 Setting Up AWS Secrets (Important)

To run the workflow successfully, users must add two secrets in:

**Repository → Settings → Secrets and Variables → Actions**

These secrets are:

* **AWS_ACCESS_KEY_ID** — access key for the IAM user
* **AWS_SECRET_ACCESS_KEY** — secret key for the IAM user

These credentials must belong to an IAM user that has permissions to:

* Use the S3 bucket defined in backend.tf
* Create EC2, VPC, and subnet resources


## ☁️ IAM Notes

Use a dedicated IAM user for GitHub Actions.
The access keys must be:

* Active
* Permanent (not temporary session keys)
* Pasted in GitHub Secrets **without quotes or spaces**

If you see errors like *“InvalidClientTokenId”*, it means the credentials are incorrect or expired.

## 🧪 How to Run This Project

### Step 1 — Fork This Repository

Anyone can copy this repository into their own account to experiment safely.

### Step 2 — Add AWS Secrets

Add the AWS credentials in GitHub repository secrets.

### Step 3 — Create Your Own S3 Bucket

The backend configuration expects a specific bucket name.
Users should change the bucket name in backend.tf to their own bucket.

### Step 4 — Insert a Valid AMI ID

The EC2 instance in main.tf requires a real AMI ID available in the selected AWS region.

### Step 5 — Trigger the Workflow

Users can go to:

**Actions → Terraform CI → Run workflow**

Where they can choose:

* plan
* apply
* destroy

## 🔍 What You’ll See

### Plan

Shows exactly what resources Terraform intends to create.

### Apply

Creates VPC, subnet, and EC2 resources.

### Destroy

Safely deletes everything while keeping the S3 state stored.

---
