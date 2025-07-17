
resource "aws_cloudwatch_log_group" "security_logs" {
  name              = "/aws/security/logs"
  retention_in_days = 90
  tags              = var.common_tags
}

resource "aws_s3_bucket_lifecycle_configuration" "log_retention" {
  bucket = var.log_bucket_name

  rule {
    id     = "expire-noncurrent"
    status = "Enabled"

    filter {} # Required for future compatibility

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}


resource "aws_cloudwatch_log_subscription_filter" "to_s3_lambda" {
  name            = "security-filter"
  log_group_name  = aws_cloudwatch_log_group.security_logs.name
  filter_pattern  = ""
  destination_arn = var.lambda_arn # Assume future Lambda destination
  depends_on      = [aws_cloudwatch_log_group.security_logs]
}
