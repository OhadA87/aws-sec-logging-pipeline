
output "sns_topic_arn" {
  value = aws_sns_topic.security_alerts.arn
}
output "securityhub_status" {
  value = aws_securityhub_account.main.id
}
