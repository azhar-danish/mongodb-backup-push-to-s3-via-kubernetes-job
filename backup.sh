#!/bin/bash

set -e

DATE=$(date +%Y-%m-%d-%H-%M-%S)

BACKUP_FILE="${MONGODB_DATABASE}-${DATE}.archive.gz"

BACKUP_PATH="/backup/${BACKUP_FILE}"

S3_PATH="s3://${S3_BUCKET}/mongodb/${MONGODB_DATABASE}/${DATE}/${BACKUP_FILE}"

echo "======================================"
echo "MongoDB Backup Started"
echo "======================================"

echo "Database : ${MONGODB_DATABASE}"
echo "Backup   : ${BACKUP_FILE}"
echo "S3 Path  : ${S3_PATH}"

mkdir -p /backup

echo ""
echo "Creating MongoDB backup..."

mongodump \
  --uri="${MONGODB_URI}" \
  --db="${MONGODB_DATABASE}" \
  --archive="${BACKUP_PATH}" \
  --gzip

echo ""
echo "Backup created successfully."

ls -lh "${BACKUP_PATH}"

echo ""
echo "Uploading backup to S3..."

aws s3 cp \
  "${BACKUP_PATH}" \
  "${S3_PATH}"

echo ""
echo "======================================"
echo "Backup uploaded successfully"
echo "======================================"

echo "S3 location:"
echo "${S3_PATH}"

echo ""
echo "Verifying S3 object..."

aws s3 ls "${S3_PATH}"

echo ""
echo "MongoDB backup completed successfully."
