terraform {
  backend "s3" {
    bucket = "yasser-backend-bucket"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}
