# Mini Terraform AWS — Free Tier Friendly

Practical mini project applying concepts from KodeKloud's Terraform beginners course to real AWS.
Shows modules, remote state (S3 + DynamoDB), clean repo structure, and cost guardrails.

## What You'll See
- VPC + public subnet + IGW + route table
- Security Group for SSH (22) and HTTP (80)
- One micro EC2 with user_data (simple web server)
- Remote state backend in S3 with DynamoDB locking
- Environment: dev

## Region
- eu-north-1 (Stockholm). Verify which micro type is Free Tier in your account (t2.micro or t3.micro).

## Backend (Remote State)
- Remote state will be stored in S3 bucket: `bucket = tmn-tfstate-chadi`
- State locking with DynamoDB table: `tmn-tf-locks`
- AWS CLI profile: `tf-dev`
- Region: `eu-north-1`
- **S3 bucket:** `tmn-tfstate-chadi` (versioning + AES256 encryption, eu-north-1)
- **Locking:** native lockfile (`use_lockfile = true`)
- **Profile:** `tf-dev`
- **Files:** `envs/dev/backend.tf` + `envs/dev/backend.hcl`
- **Init command:** `terraform -chdir=envs/dev init -backend-config=backend.hcl`

## VPC & Networking
- Creates a VPC (10.0.0.0/16)
- Public subnet (10.0.1.0/24)
- Internet Gateway
- Route Table + Association
- Outputs: VPC ID, Public Subnet ID

## Compute (EC2)
- Launches a single Free Tier eligible EC2 (t3.micro or t2.micro)
- Amazon Linux 2023 AMI (x86_64)
- User data installs Apache and serves a test page
- Root volume: 8 GB gp3, encrypted
- Outputs: instance_id, public_ip, public_dns


## Ansible Integration
This repo demonstrates infra (Terraform) + config (Ansible).

- Terraform provisions VPC/Subnet/SG/EC2.
- Ansible configures the EC2 (installs Apache, deploys a test page).

### How to run
1) Import your SSH public key as an EC2 key pair (e.g., `shadi-rsa`) and set `key_name` in `envs/dev/main.tf`.
2) `terraform -chdir=envs/dev apply`
3) Generate inventory:
   ```bash
   EC2_IP="$(terraform -chdir=envs/dev output -raw ec2_public_ip)"
   cat > ansible/inventory.ini <<EOF
   [web]
   $EC2_IP

   [web:vars]
   ansible_user=ec2-user
   ansible_ssh_private_key_file=~/.ssh/id_rsa
   EOF


## Cost Safety
- Micro instance only, small gp3 volume, no Elastic IP unless needed
- Clear tags: project=terraform-mini, env=dev, owner=El-shado, cost=free-tier
- Remember to destroy after testing

## Repo Structure (Planned)
See `PROJECT_DECISIONS.md` for details.


