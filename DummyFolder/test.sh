#!/bin/bash
# demo_simple.sh - sample migration script

SRC_DIR=/tmp/demo_src
DEST_DIR=/tmp/demo_dest
LOG=/tmp/demo_simple.log

echo "Migration started at $(date)"
mkdir -p $DEST_DIR
cp -r $SRC_DIR/* $DEST_DIR/
echo "Migration completed at $(date)"

exit 0