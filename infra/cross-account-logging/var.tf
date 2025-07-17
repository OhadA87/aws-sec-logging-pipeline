

variable "central_log_bucket_name" {
  description = "Name of the centralized logging S3 bucket"
  type        = string
}

variable "allowed_account_ids" {
  description = "List of AWS account IDs allowed to write logs"
  type        = list(string)
}

variable "common_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "centralized_log_bucket_name" {
  description = "Name of the centralized log bucket"
  type        = string
}

