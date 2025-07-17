

resource "aws_s3_bucket" "centralized_logs" {
  bucket        = var.centralized_log_bucket_name
  force_destroy = true
}


resource "aws_kms_key" "log_key" {
  description             = "KMS key for centralized log bucket encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = var.common_tags
}

resource "aws_kms_alias" "log_key_alias" {
  name          = "alias/${var.central_log_bucket_name}-key"
  target_key_id = aws_kms_key.log_key.key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.centralized_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.log_key.arn
    }
  }
}

resource "aws_s3_bucket_policy" "allow_cross_account" {
  bucket = aws_s3_bucket.centralized_logs.id
  policy = data.aws_iam_policy_document.cross_account.json
}

data "aws_iam_policy_document" "cross_account" {
  statement {
    sid    = "AllowWriteFromOtherAccounts"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.allowed_account_ids
    }

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]

    resources = [
      "${aws_s3_bucket.centralized_logs.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}


