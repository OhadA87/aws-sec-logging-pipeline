
# Logging Foundation (Day 1)

This Terraform module deploys the base infrastructure for centralized logging and threat detection in AWS.
It includes:
- CloudTrail (multi-region, all management + data events)
- KMS-encrypted, versioned S3 bucket for log storage
- Public access blocking on S3
- GuardDuty enabled for real-time threat intelligence

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `log_bucket_name` | The name of the S3 bucket for logs | `string` | yes |
| `common_tags` | Tags to apply to all resources | `map(string)` | yes |

## Outputs

| Name | Description |
|------|-------------|
| `cloudtrail_bucket_name` | The S3 bucket name |
| `cloudtrail_arn` | The ARN of the CloudTrail |
| `kms_key_arn` | The ARN of the KMS key |
