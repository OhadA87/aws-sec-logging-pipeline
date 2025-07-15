
provider "aws" {
  region = "us-east-1"
}

# KMS Key (optional – reuse from foundation if desired)
resource "aws_kms_key" "trail_key" {
  description             = "KMS key for test CloudTrail encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 10
}

# S3 Bucket for test logs
resource "aws_s3_bucket" "test_log_bucket" {
  bucket = var.trail_test_bucket_name

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = var.common_tags
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket                  = aws_s3_bucket.test_log_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt" {
  bucket = aws_s3_bucket.test_log_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.trail_key.arn
    }
  }
}

# CloudTrail for test scenarios
resource "aws_cloudtrail" "test_trail" {
  name                          = "test-security-trail"
  s3_bucket_name                = aws_s3_bucket.test_log_bucket.id
  is_multi_region_trail         = false
  include_global_service_events = true
  enable_logging                = true
  kms_key_id                    = aws_kms_key.trail_key.arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }

    data_resource {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"]
    }
  }

  tags = var.common_tags
}

# S3 Bucket Policy for CloudTrail Write Access
resource "aws_s3_bucket_policy" "trail_write_policy" {
  bucket = aws_s3_bucket.test_log_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "AllowCloudTrailWrite",
        Effect: "Allow",
        Principal: {
          Service: "cloudtrail.amazonaws.com"
        },
        Action: "s3:PutObject",
        Resource: "${aws_s3_bucket.test_log_bucket.arn}/AWSLogs/*",
        Condition: {
          StringEquals: {
            "s3:x-amz-acl": "bucket-owner-full-control"
          }
        }
      },
      {
        Sid: "DenyUnencryptedAccess",
        Effect: "Deny",
        Principal: "*",
        Action: "s3:*",
        Resource: [
          "${aws_s3_bucket.test_log_bucket.arn}",
          "${aws_s3_bucket.test_log_bucket.arn}/*"
        ],
        Condition: {
          Bool: {
            "aws:SecureTransport": "false"
          }
        }
      }
    ]
  })
}
