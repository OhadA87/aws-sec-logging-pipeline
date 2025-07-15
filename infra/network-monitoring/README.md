
# Network Monitoring Module

This module deploys VPC Flow Logs and DNS Resolver logging to CloudWatch Logs.
It also defines metric filters to detect scanning or exfiltration behavior (e.g., denied SSH attempts).

## Features

- VPC Flow Logs (traffic: ALL)
- DNS Query Logs (via Route53 Resolver)
- CloudWatch Metric Filters
- SNS alerting when SSH port scan is detected
