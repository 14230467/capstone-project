BUCKET_NAME="project22-s3-log-archive-14230467"

# 1. Create the S3 bucket
aws s3 mb "s3://${BUCKET_NAME}" --region ap-south-1

# 2. Create a compressed log archive and upload it under the logs/ prefix
tar -czf /tmp/system-logs-archive.tar.gz /var/log/syslog 2>/dev/null
aws s3 cp /tmp/system-logs-archive.tar.gz "s3://${BUCKET_NAME}/logs/system-logs-$(date +%Y-%m-%d).tar.gz"
rm -f /tmp/system-logs-archive.tar.gz

# 3. Verify the uploaded log file
aws s3 ls "s3://${BUCKET_NAME}/logs/" --human-readable
