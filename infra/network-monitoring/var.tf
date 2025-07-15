
variable "target_vpc_id" {
  description = "The VPC to monitor"
  type        = string
}

variable "alert_sns_topic_arn" {
  description = "SNS topic ARN for alerting"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}
