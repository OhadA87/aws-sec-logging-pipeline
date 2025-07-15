
output "cloudtrail_bucket_name" {
  value = aws_s3_bucket.cloudtrail_logs.id
}

output "cloudtrail_arn" {
  value = aws_cloudtrail.main.arn
}

output "kms_key_arn" {
  value = aws_kms_key.cloudtrail_key.arn
}
