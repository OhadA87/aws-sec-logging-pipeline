
# === CloudWatch Log Group for VPC Flow Logs ===
resource "aws_cloudwatch_log_group" "vpc_log_group" {
  name              = "/aws/vpc/flowlogs"
  retention_in_days = 30

  tags = var.common_tags
}

# === IAM Role for VPC Flow Logs to CW Logs ===
resource "aws_iam_role" "vpc_flowlog_role" {
  name = "vpc-flowlogs-delivery-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy" "vpc_flowlog_policy" {
  name = "vpc-flowlogs-policy"
  role = aws_iam_role.vpc_flowlog_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "${aws_cloudwatch_log_group.vpc_log_group.arn}:*"
      }
    ]
  })
}

# === Enable VPC Flow Logs ===
resource "aws_flow_log" "vpc_logs" {
  log_destination_type = "cloud-watch-logs"
  log_group_name       = aws_cloudwatch_log_group.vpc_log_group.name
  iam_role_arn         = aws_iam_role.vpc_flowlog_role.arn
  traffic_type         = "ALL"
  vpc_id               = var.target_vpc_id

  tags = var.common_tags
}

# === Route 53 Resolver DNS Logs ===
resource "aws_route53_resolver_query_log_config" "dns_logs" {
  name            = "dns-query-logs"
  destination_arn = aws_cloudwatch_log_group.vpc_log_group.arn

  tags = var.common_tags
}

resource "aws_route53_resolver_query_log_config_association" "dns_association" {
  resolver_query_log_config_id = aws_route53_resolver_query_log_config.dns_logs.id
  resource_id                  = var.target_vpc_id
}

# === Metric Filter: Detect port scan (denied port 22) ===
resource "aws_cloudwatch_log_metric_filter" "port_scan_filter" {
  name           = "DeniedSSHScan"
  log_group_name = aws_cloudwatch_log_group.vpc_log_group.name

  pattern = "{ $.action = \"REJECT\" && $.dstport = 22 }"

  metric_transformation {
    name      = "DeniedSSHAttempts"
    namespace = "SecurityLogs"
    value     = "1"
  }
}

# === Alarm: SSH Scan Detected ===
resource "aws_cloudwatch_metric_alarm" "ssh_scan_alarm" {
  alarm_name          = "SSHPortScanDetected"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = aws_cloudwatch_log_metric_filter.port_scan_filter.metric_transformation[0].name
  namespace           = "SecurityLogs"
  period              = 60
  statistic           = "Sum"
  threshold           = 2
  alarm_actions       = [var.alert_sns_topic_arn]
}
