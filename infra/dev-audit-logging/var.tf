
variable "trail_test_bucket_name" {
  description = "S3 bucket name for test CloudTrail logs"
  type        = string
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
}
