#!/bin/bash
# TMPFILE=$(mktemp)
# echo "Our temp file is $TMPFILE"

trap 'rm -f "$TMPFILE"' EXIT

TMPFILE=$(mktemp) || exit 1
echo "Our temp file is $TMPFILE"

mktemp -d
mktemp -p /home/li/
mktemp -t mytemp.XXXXXXX