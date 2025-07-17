

variable "region" {
  description = "AWS Region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "alert_email" {
  description = "Email address to receive security alerts"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}
