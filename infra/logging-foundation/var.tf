
variable "log_bucket_name" {
  description = "Name of the S3 bucket for CloudTrail logs"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

# In your variables.tf
variable "aws_region" {
  default     = "us-east-1"
}
