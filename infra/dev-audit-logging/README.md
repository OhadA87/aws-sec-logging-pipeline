
# Test CloudTrail Scenario – Simulation Environment

This module sets up a separate CloudTrail + S3 bucket intended for detection use cases:
- Public S3 exposure
- Manual IAM user creation
- Unauthorized config changes

## Included Resources
- S3 bucket with encryption, versioning, lifecycle
- CloudTrail logging S3 + Lambda activity
- Bucket policy for CloudTrail
- Optional: KMS key for encrypted storage

Use this module when simulating attack scenarios or validating GuardDuty + Security Hub detection flows.
