#!/bin/bash
# demo_shellscript.sh - sample migration script

SRC_DIR=/tmp/demo_src
DEST_DIR=$XXTRINITI_TOP/demo_dest

echo "Migration started at $(date)"
echo "Destination directory: $DEST_DIR"

mkdir -p $DEST_DIR
cp -r $SRC_DIR/* $DEST_DIR/

echo "Migration completed at $(date)"
echo "Files migrated to: $DEST_DIR"

exit 0
