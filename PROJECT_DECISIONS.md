# Project Decisions

## Objective
Build a small, Free-Tier-friendly AWS environment using Terraform to demonstrate real IaC practices (modules, remote state, Git repo hygiene).

## Scope (Chosen)
Option A:
- VPC (single / public subnet)
- Internet Gateway + Route Table
- Security Group (SSH + HTTP)
- 1 EC2 instance (micro) with user_data to install a simple web server
- Remote state: S3 backend + DynamoDB lock
- Environment: dev only

## Region
- Primary: eu-north-1 (Stockholm)  ← قريب منك
- Note: Confirm Free Tier eligible micro type in your account (t2.micro or t3.micro).

## Cost Guardrails
- EC2: micro type only (t2.micro or t3.micro per Free Tier eligibility)
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
