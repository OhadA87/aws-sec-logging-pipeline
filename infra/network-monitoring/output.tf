
output "vpc_log_group" {
  value = aws_cloudwatch_log_group.vpc_log_group.name
}
