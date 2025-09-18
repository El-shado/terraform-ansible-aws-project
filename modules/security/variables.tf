variable "vpc_id" {
  description = "ID of the VPC where the SG will be created"
  type        = string
}

variable "ssh_ingress_cidr" {
  description = "CIDR block allowed for SSH access"
  type        = string
}

variable "tags" {
  description = "Default tags for resources"
  type        = map(string)
  default     = {}
}
