# Project Decisions

## Objective
Build a small, AWS environment using Terraform to demonstrate real IaC practices (modules, remote state, Git repo hygiene).

## Scope (Chosen)
Option A:
- VPC (single / public subnet)
- Internet Gateway + Route Table
- Security Group (SSH + HTTP)
- 1 EC2 instance (micro) with user_data to install a simple web server
- Remote state: S3 backend + DynamoDB lock
- Environment: dev only

## Region
- Primary: eu-north-1 (Stockholm)  
- Note: Confirm Free Tier eligible micro type in your account (t2.micro or t3.micro).

## Cost Guardrails
- EC2: micro type only (t2.micro or t3.micro)
- EBS: 8–10 GB gp3
- No Elastic IP unless really needed
- Always tag resources for tracking
- Destroy after testing

## Naming Conventions
- Prefix: tmn
- Pattern: tmn-<component>-<env>
  - Examples: tmn-vpc-dev, tmn-web-sg-dev, tmn-ec2-web-dev
- S3 state bucket: tmn-tfstate-<your-unique-suffix>
- DynamoDB table: tmn-tf-locks

## Tagging Standard
- project = terraform-mini
- env     = dev
- owner   = <your-github-username>
- cost    = free-tier

## Repository Layout (Planned)
envs/
  dev/
    main.tf
    variables.tf
    outputs.tf
    provider.tf
    backend.tf
modules/
  vpc/
  security/
  compute/
docs/
examples/
.github/

## Git Strategy
- Default branch: main (protected)
- Feature branches: feat/*, docs/*, chore/*
- Commit format: type(scope): summary
  - e.g., feat(vpc): add public subnet

## Acceptance Criteria
- Clear README explaining objective, scope, cost safety
- No secrets committed (.tfstate, .tfvars ignored)
- Consistent naming & tags
- Repo looks professional (topics, description, LICENSE)

## Milestones (High Level)
1) Scaffold & Guardrails
2) Backend & State (S3 + DynamoDB)
3) Modules (vpc, security, compute)
4) Docs & Polish

## AWS Account & Auth (Planned)
- Account: personal AWS account
- AWS CLI Profile Name: tf-beginner
- Instance Micro Type (to confirm in eu-north-1): <t2.micro or t3.micro>

## Phase 1 Checklist
+ [ ] Objective defined and written
+ [ ] Scope chosen (Option A)
+ [ ] Region selected (eu-north-1) with Free Tier note
+ [ ] Cost guardrails documented
+ [ ] Naming conventions decided
+ [ ] Tagging standard decided
+ [ ] Repo layout planned
+ [ ] Git strategy defined
+ [ ] Acceptance criteria listed
+ [ ] README initial draft created
+ [ ] .gitignore created
+ [ ] docs/ notes started

## Phase 2 Checklist
+ [ ] Terraform installed and version checked
+ [ ] AWS CLI installed and version checked
+ [ ] Git installed and version checked
+ [ ] Local repo initialized with git init
+ [ ] First commit created (README, gitignore, decisions)
+ [ ] GitHub repo created (public)
+ [ ] Remote origin added and pushed to main
+ [ ] Folder structure created (envs/, modules/, docs/, .github/, examples/)
+ [ ] Empty Terraform files added in envs/dev (main.tf, variables.tf, outputs.tf, provider.tf, backend.tf)
+ [ ] Second commit pushed (structure)
+ [ ] GitHub topics and description updated



## Phase 3 Checklist
+ [ ] provider.tf created with AWS provider block
+ [ ] backend.tf created with S3 + DynamoDB config (placeholders only)
+ [ ] Region confirmed (eu-north-1)
+ [ ] Profile name decided (tf-dev)
+ [ ] README updated with backend details
+ [ ] Commit pushed to GitHub


## Phase 4 Checklist
+ [ ] vpc module folder created (main.tf, variables.tf, outputs.tf)
+ [ ] VPC resource defined
+ [ ] Internet Gateway defined
+ [ ] Public Subnet defined
+ [ ] Route Table + default route defined
+ [ ] Subnet association created
+ [ ] Outputs for VPC ID and Subnet ID
+ [ ] Module called in envs/dev/main.tf
+ [ ] README updated with Phase 4 description
+ [ ] Commit pushed to GitHub


## Phase 5 Checklist
+ [ ] security module folder created (main.tf, variables.tf, outputs.tf)
+ [ ] SG resource defined (SSH + HTTP)
+ [ ] SSH restricted to my IP only
+ [ ] Outputs for SG ID created
+ [ ] Module called in envs/dev/main.tf
+ [ ] README updated with Phase 5
+ [ ] Commit pushed to GitHub
  
## Phase 6 Checklist
+ [ ] compute module created (main.tf, variables.tf, outputs.tf, user_data.sh)
+ [ ] AMI data source set to Amazon Linux 2023
+ [ ] Instance type set to Free Tier (t3.micro/t2.micro)
+ [ ] SG and Subnet wired from previous modules
+ [ ] User data installs Apache & test page
+ [ ] Outputs (instance_id, public_ip, public_dns)
+ [ ] Module called from envs/dev/main.tf
+ [ ] README updated with Phase 6
+ [ ] Commit pushed to GitHub


## Phase 7 Checklist
+ [ ] IAM user created (tf-dev) with programmatic access
+ [ ] AWS CLI profile configured (tf-dev, eu-north-1)
+ [ ] S3 bucket created (unique, versioning + encryption)
+ [ ] Backend configured (lockfile) and `terraform init` completed from envs/dev
+ [ ] README updated with backend details
+ [ ] Commit pushed to GitHub

## Phase 8 Checklist
+ [ ] terraform fmt and validate passed
+ [ ] terraform plan reviewed (Free Tier instance & small volume)
+ [ ] terraform apply completed successfully
+ [ ] Web page reachable via EC2 public IP (HTTP 80)
+ [ ] README updated with screenshots
+ [ ] terraform destroy executed (clean teardown)
+ [ ] Commit(s) pushed to GitHub