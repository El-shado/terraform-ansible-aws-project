terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "eu-north-1"   # Stockholm (قريب لك)
  profile = "tf-dev"  # هننشئه لاحقًا بالـ AWS CLI في مرحلة الاعتمادات
}
