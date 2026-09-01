sudo bash -c 'cat << "EOF" > /usr/local/bin/automated-backup.sh
#!/usr/bin/env bash
# ==============================================================================
# Script Name: automated-backup.sh
# Description: Automated directory backup with compression, logging, and retention.
# Author: IT Support Operations
# ==============================================================================

set -euo pipefail

# Configuration
BACKUP_SRC="/var/log"
BACKUP_DEST="/opt/backups"
LOG_FILE="/var/log/homelab-backup.log"
RETENTION_DAYS=7
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="backup_$(hostname)_${TIMESTAMP}.tar.gz"

# Ensure destination directory and log file exist
mkdir -p "${BACKUP_DEST}"
touch "${LOG_FILE}"

log_msg() {
    local LEVEL="$1"
    local MSG="$2"
    echo "[$(date '+\%Y-\%m-\%d \%H:\%M:\%S')] [${LEVEL}] ${MSG}" \vert{} tee -a "${LOG_FILE}"
}

log_msg "INFO" "Starting backup process for: ${BACKUP_SRC}"

# Verify source directory exists
if [ ! -d "${BACKUP_SRC}" ]; then
    log_msg "ERROR" "Source directory ${BACKUP_SRC} does not exist. Aborting."
    exit 1
fi

# Execute compressed backup
if tar -czf "${BACKUP_DEST}/${ARCHIVE_NAME}" -C "$(dirname "${BACKUP_SRC}")" "$(basename "${BACKUP_SRC}")" 2>> "${LOG_FILE}"; then
    ARCHIVE_SIZE=$(du -h "${BACKUP_DEST}/${ARCHIVE_NAME}" | cut -f1)
    log_msg "SUCCESS" "Archive created: ${ARCHIVE_NAME} (Size:${ARCHIVE_SIZE})"
else
    log_msg "ERROR" "Failed to create archive ${ARCHIVE_NAME}"
    exit 1
fi

# Retention Cleanup: Remove backups older than retention threshold
log_msg "INFO" "Executing retention policy (Purging files older than ${RETENTION_DAYS} days)..."
DELETED_COUNT=0
while IFS= read -r file; do
    if [ -n "$file" ]; then
        rm -f "$file"
        log_msg "INFO" "Purged expired archive: $(basename "$file")"
        DELETED_COUNT=$((DELETED_COUNT + 1))
    fi
done < <(find "${BACKUP_DEST}" -type f -name "backup_*.tar.gz" -mtime +"${RETENTION_DAYS}")

log_msg "SUCCESS" "Retention cleanup complete. ${DELETED_COUNT} file(s) removed."
log_msg "INFO" "Backup job finished successfully."
EOF'

# Grant execution permissions
sudo chmod 750 /usr/local/bin/automated-backup.sh