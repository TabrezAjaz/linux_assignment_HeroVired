#!/usr/bin/env bash
set -euo pipefail
umask 022
DATE=$(date +%F)
BACKUP_FILE="/backups/nginx_backup_${DATE}.tar.gz"
VERIFY_LOG="/var/log/devops-assignment/nginx_verify_${DATE}.log"

rm -f "$BACKUP_FILE" "$VERIFY_LOG"
# Nginx backup scope required by assignment
tar -czf "$BACKUP_FILE" /etc/nginx /usr/share/nginx/html

echo "Backup file: $BACKUP_FILE" > "$VERIFY_LOG"
tar -tzf "$BACKUP_FILE" | head -n 200 >> "$VERIFY_LOG"
