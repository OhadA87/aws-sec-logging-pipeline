
# Security Alerting Module

This Terraform module provisions a real-time alerting pipeline that monitors suspicious activity — specifically SSH traffic — using VPC Flow Logs, CloudWatch Logs, Metric Filters, and SNS email notifications.

## Purpose

Simulate real-world detection and alerting as implemented in high-tech companies to respond to:

- **Unauthorized SSH access attempts**
- **Brute-force scanning behavior**
- **Network intrusions via port 22**

## Resources Created

- **VPC Flow Logs** 
- **CloudWatch Log Group & Log Stream**
- **Metric Filter**: Monitors for SSH attempts
- **CloudWatch Alarm**: Triggers on suspicious SSH activity
- **SNS Topic**: Delivers alerts to specified email
- **Subscription**: Email subscription for alert delivery

## 🔧 Input Variables

| Name         | Type        | Description                          |
|--------------|-------------|--------------------------------------|
| `region`     | `string`    | AWS region to deploy to              |
| `alert_email`| `string`    | Email address to receive alerts      |
| `common_tags`| `map(string)`| Common tags applied to all resources|

## 🚀 Usage

```hcl
module "security_alerting" {
  source      = "./infra/security-alerting"
  region      = "us-east-1"
  alert_email = "security-team@example.com"
  common_tags = {
    Owner       = "Ohad Antebi"
    Environment = "dev"
    Project     = "AWS-Security-Logging-Pipeline"
  }
}
