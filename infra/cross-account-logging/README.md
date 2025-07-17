

# Cross-Account Centralized Logging Module

This module provisions a **KMS-encrypted S3 bucket** to collect cross-account log data. Only whitelisted AWS accounts can write logs to this bucket with specific permissions (`bucket-owner-full-control`).

---

## What It Does

- Creates an S3 bucket and passed in as a variable
- Configures lifecycle retention rules (delete after 30 days)
- Adds a KMS key and alias for encryption
- Grants write-only cross-account permissions for logging

---

## Usage

```hcl
module "cross_account_logging" {
  source = "./infra/cross-account-logging"

  centralized_log_bucket_name = var.centralized_log_bucket_name
  lambda_arn                  = var.lambda_arn
  allowed_account_ids         = var.allowed_account_ids
  common_tags                 = var.common_tags
}
