

# 📘 Centralized Security Logging

This module provisions:

- CloudWatch log group for security-related logs
- Lifecycle configuration for log archiving and cleanup
- Log subscription filter to forward logs to downstream processors (e.g. Lambda, SIEM)

## 🚀 Future Improvements
- Add Kinesis Firehose integration
- Connect with third-party SIEM (e.g. Splunk, Datadog)
- Apply GuardDuty/Macie/Inspector custom filters
