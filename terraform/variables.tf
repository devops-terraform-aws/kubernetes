variable "bucket_names" {
  type = map(string)
  default = {
    development = "my-dev-bucket"
    staging     = "my-staging-bucket"
    production  = "my-prod-bucket"
  }
}

variable "region" {
  type    = list(string)
  default = ["us-east-1", "us-east-2"]
}