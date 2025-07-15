
output "test_trail_name" {
  value = aws_cloudtrail.test_trail.name
}

output "test_trail_bucket" {
  value = aws_s3_bucket.test_log_bucket.bucket
}

output "trail_kms_key_arn" {
  value = aws_kms_key.trail_key.arn
}
