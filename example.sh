#!/bin/bash
# =========================
# Daily Backup Script
# =========================
# This script can:
# 1. Backup a folder
# 2. List backups
# 3. Delete all backups

# Stop the script if any command fails
set -e  

# --------- Functions ---------

# Log messages with date and time
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Backup a folder
backup_folder() {
  local src=$1   # Source folder to backup
  local dest=$2  # Destination backup folder

  # Check if source exists
  if [ ! -d "$src" ]; then
    echo "Error: Source folder $src does not exist!"
    exit 1
  fi

  # Create destination folder if it doesn't exist
  mkdir -p "$dest"

  # Copy all files from source to destination
  cp -r "$src" "$dest"

  log "Backup of $src completed to $dest"
}

# List all backups in the backup folder
list_backups() {
  local dir=$1
  if [ ! -d "$dir" ]; then
    echo "No backups found!"
    return
  fi
  echo "Backups in $dir:"
  ls -lh "$dir"
}

# Delete all backups
clean_backups() {
  local dir=$1
  if [ ! -d "$dir" ]; then
    echo "No backups to clean!"
    return
  fi
  rm -rf "$dir"/*
  log "All backups in $dir have been deleted!"
}

# --------- Main Script ---------

# Where backups will be stored
BACKUP_DIR="$HOME/backups"

# Create a timestamp for this backup (e.g., 2026-02-04_14-30-00)
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')

# Decide what action to do based on the first argument
case "$1" in
  backup)
    # Backup requires a source folder as the second argument
    SRC_DIR="$2"
    if [ -z "$SRC_DIR" ]; then
      echo "Usage: $0 backup <source_folder>"
      exit 1
    fi
    # Call the backup function
    backup_folder "$SRC_DIR" "$BACKUP_DIR/$TIMESTAMP"
    ;;
  list)
    # List all backups
    list_backups "$BACKUP_DIR"
    ;;
  clean)
    # Delete all backups
    clean_backups "$BACKUP_DIR"
    ;;
  *)
    # Show usage if no valid action is provided
    echo "Usage: $0 {backup <folder>|list|clean}"
    exit 1
    ;;
esac

