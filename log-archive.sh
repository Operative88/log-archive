#!/usr/bin/env bash

# log-archive - narzędzie CLI do archiwizacji logów


set -euo pipefail


if [ "$#" -ne 1 ]; then
    echo "Użycie: log-archive <katalog-z-logami>"
    exit 1
fi

LOG_DIR="$1"


if [ ! -d "$LOG_DIR" ]; then
    echo "Błąd: '$LOG_DIR' nie jest katalogiem lub nie istnieje."
    exit 1
fi


ARCHIVE_DIR="${LOG_DIR%/}/archives"      # podkatalog na archiwa
mkdir -p "$ARCHIVE_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")        # np. 20240816_100648
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_NAME}"


# -c: utwórz, -z: gzip, -f: plik wyjściowy, -C: wejdź do katalogu przed pakowaniem
# --exclude="archives": nie pakuj katalogu z archiwami
tar -czf "$ARCHIVE_PATH" -C "$LOG_DIR" --exclude="archives" .


LOG_FILE="${ARCHIVE_DIR}/archive.log"
echo "$(date +"%Y-%m-%d %H:%M:%S") - Utworzono archiwum: $ARCHIVE_PATH" >> "$LOG_FILE"

echo "Archiwum utworzone: $ARCHIVE_PATH"
