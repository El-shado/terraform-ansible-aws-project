# Walkthrough — init → plan → apply → test → destroy

## Prereqs
- AWS profile: `tf-dev`, Region: `eu-north-1`
- Backend S3: `tmn-tfstate-chadi`
- SSH CIDR: set via `envs/dev/terraform.tfvars` → `ssh_ingress_cidr = "83.187.176.137/32"`

## 1) Init & Validate
terraform -chdir=envs/dev init -backend-config=backend.hcl
terraform -chdir=envs/dev fmt -recursive
terraform -chdir=envs/dev validate

## 2) Plan
terraform -chdir=envs/dev plan -out=tfplan
terraform -chdir=envs/dev show -no-color tfplan > docs/terraform-plan.txt

## 3) Apply
terraform -chdir=envs/dev apply tfplan
terraform -chdir=envs/dev output > docs/terraform-output.txt
# Quick check:
curl "http://$(terraform -chdir=envs/dev output -raw ec2_public_ip)/"

## 4) (Optional) Ansible
# After apply:
EC2_IP="$(terraform -chdir=envs/dev output -raw ec2_public_ip)"
cat > ansible/inventory.ini <<EOI
[web]
$EC2_IP

[web:vars]
ansible_user=ec2-user
ansible_ssh_private_key_file=~/.ssh/id_rsa
EOI
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml

## 5) Screenshots
- Save in `docs/`: web-homepage.png, terraform-plan.txt, terraform-output.txt

## 6) Destroy (to keep cost = 0)
terraform -chdir=envs/dev destroy
