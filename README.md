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

## VPC & Networking
- Creates a VPC (10.0.0.0/16)
- Public subnet (10.0.1.0/24)
- Internet Gateway
- Route Table + Association
- Outputs: VPC ID, Public Subnet ID


## Cost Safety
- Micro instance only, small gp3 volume, no Elastic IP unless needed
- Clear tags: project=terraform-mini, env=dev, owner=<chadi.kawaf@gmail.com>, cost=free-tier
- Remember to destroy after testing

## Repo Structure (Planned)
See `PROJECT_DECISIONS.md` for details.


