#!/bin/bash

set -euo pipefail

if [ "$#" -ne 1 ] then;
echo "Użycie: "log-archive <katalog-z-logami>"
exit 1
fi

LOG_DIR="$1"

if [ ! -d "$LOG_DIR" ] then;
echo "katalog '$LOG_DIR' jest nieprawidłowy lub nie istnieje"
exit 1
fi

ARCHIVE_DIR="${LOG_DIR%/}/archives}"
mkdir -p "$ARCHIVE_DIR"
TIMESTAMP=$(date +"%y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"

tar -czf "$ARCHIVE_PATH" -C "$LOG_DIR" --exclude="archives" .
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_NAME}"

LOG_FILE="${ARCHIVE_DIR}/archive.log"
echo "$(date +"%Y-%m-%d %H:%M:%S") - Utworzono archiwum: $ARCHIVE_PATH" >> "$LOG_FILE"

echo "Archiwum utworzone: $ARCHIVE_PATH"





