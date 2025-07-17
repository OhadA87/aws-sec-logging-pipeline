

output "central_log_group_name" {
  value = aws_cloudwatch_log_group.security_logs.name
}

output "log_bucket_lifecycle_rule" {
  value = aws_s3_bucket_lifecycle_configuration.log_retention.rule
}
