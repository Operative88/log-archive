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


