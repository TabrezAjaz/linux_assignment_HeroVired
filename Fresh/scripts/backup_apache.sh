#!/usr/bin/env bash
set -euo pipefail
umask 022
DATE=$(date +%F)
BACKUP_FILE="/backups/apache_backup_${DATE}.tar.gz"
VERIFY_LOG="/var/log/devops-assignment/apache_verify_${DATE}.log"

rm -f "$BACKUP_FILE" "$VERIFY_LOG"
# Apache backup scope required by assignment
tar -czf "$BACKUP_FILE" /etc/httpd /var/www/html

echo "Backup file: $BACKUP_FILE" > "$VERIFY_LOG"
tar -tzf "$BACKUP_FILE" | head -n 200 >> "$VERIFY_LOG"
