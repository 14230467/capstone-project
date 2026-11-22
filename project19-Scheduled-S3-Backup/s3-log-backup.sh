sudo tee /usr/local/bin/s3-log-backup.sh > /dev/null <<'EOF'
#!/bin/bash
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
HOSTNAME=$(hostname)
BACKUP_FILE="/tmp/${HOSTNAME}-syslog-${TIMESTAMP}.tar.gz"
BUCKET_NAME="capstone-log-backups-14230467"

# Compress the log file
tar -czf "${BACKUP_FILE}" /var/log/syslog 2>/dev/null

# Upload to S3
/usr/local/bin/aws s3 cp "${BACKUP_FILE}" "s3://${BUCKET_NAME}/backups/"

# Clean up local temporary archive
rm -f "${BACKUP_FILE}"
EOF
