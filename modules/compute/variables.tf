variable "subnet_id" {
  description = "Public subnet ID where the EC2 will be placed"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID to attach to the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type (Free Tier eligible)"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS key pair name for SSH (optional)"
  type        = string
  default     = ""
}

variable "volume_size_gb" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 8
}

variable "tags" {
  description = "Default tags for resources"
  type        = map(string)
  default     = {}
}
