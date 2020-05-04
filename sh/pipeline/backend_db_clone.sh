#!/bin/bash

# Main DB name
DB_NAME="laravel"
# File for dump main DB
DUMP_FILE_WO_AUTOINC="/tmp/wo_autoinc_dump.sql"

echo "Create  dump from DB $DB_NAME"
mysqldump --opt --single-transaction --skip-extended-insert --no-create-info -uroot -proot $DB_NAME | grep "^INSERT" > $DUMP_FILE_WO_AUTOINC 2>/dev/null

# Create new DBs and copy data from main DB
for i in $(seq 1 8); do
  # New DB name
  DB_NAME_NEW="${DB_NAME}_${i}"

  echo "Create DB $DB_NAME_NEW and import data"
  mysql -uroot -proot -e "create database $DB_NAME_NEW" 2>/dev/null
  mysqldump -uroot -proot $DB_NAME 2>/dev/null | mysql -uroot -proot $DB_NAME_NEW 2>/dev/null
done
