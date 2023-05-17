# resource "aws_s3_bucket" "my_buckets" {
#   for_each = var.bucket_names

#   bucket = "${each.value}-${random_id.name.hex}"

#   # Add other necessary configurations for the S3 bucket
# }

resource "random_id" "name" {
  byte_length = 2
}

