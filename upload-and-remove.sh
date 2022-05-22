#!/bin/bash

URL=$1
FILENAME=$2
BASENAME=`basename $FILENAME`

curl -s -X PUT --upload-file "$FILENAME" "$URL$BASENAME" && rm -f "$FILENAME"
