

output "centralized_bucket_name" {
  value = aws_s3_bucket.centralized_logs.bucket
}

output "kms_key_arn" {
  value = aws_kms_key.log_key.arn
}
