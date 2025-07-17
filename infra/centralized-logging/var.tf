



variable "log_bucket_name" {
  type        = string
  description = "S3 bucket for centralized logs"
}

variable "lambda_arn" {
  type        = string
  description = "ARN of Lambda function to receive filtered logs"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for all resources"
}
