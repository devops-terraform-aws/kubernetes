# output "bucket" {
#   value = [for key in keys(var.bucket_names) : aws_s3_bucket.my_buckets[key].arn]
# }