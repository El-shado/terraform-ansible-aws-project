terraform {
  backend "s3" {
    bucket         = "bucket = "tmn-tfstate-chadi" 
    key            = "dev/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "tmn-tf-locks"
    encrypt        = true
    profile        = "tf-dev"
  }
}
