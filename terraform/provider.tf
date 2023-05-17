provider "aws" {
  alias  = "us-east"     # Alias for the provider block
  region = var.region[0] # Use the first region from the list
  profile = "default"
}

provider "aws" {
  alias  = "us-east-2"   # Alias for the provider block
  region = var.region[1] # Use the second region from the list
  profile = "default"
}