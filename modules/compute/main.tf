# AMI: Amazon Linux 2023 (x86_64)
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["137112412989"] # Amazon

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

locals {
  final_tags = merge(var.tags, { Name = "tmn-ec2-web-dev" })
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  
  associate_public_ip_address = true

 
  key_name = var.key_name == "" ? null : var.key_name

  
  user_data = file("${path.module}/user_data.sh")

  
  root_block_device {
    volume_size = var.volume_size_gb
    volume_type = "gp3"
    encrypted   = true
  }

  # IMDSv2
  metadata_options {
    http_tokens = "required"
  }

  tags = local.final_tags
}
