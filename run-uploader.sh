#!/bin/bash


DIR=$1
BASE_URL=$2

while true ; do
    echo "Start loop"
    find "$DIR" -name "*.ts" | xargs -r -n 1 /root/upload-and-remove.sh "$BASE_URL"
    sleep 1
done
