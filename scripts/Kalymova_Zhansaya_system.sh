#!/bin/bash
# System information script - Kalymova Zhansaya, DevOps Lab 1

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INFO_FILE="$SCRIPT_DIR/../Kalymova_Zhansaya_info.txt"
LINE="=============================="

echo "$LINE"
echo "Student Information"
echo "$LINE"
echo "Name: Zhansaya"
echo "Surname: Kalymova"
echo "Group: IT2-2312"
echo "Student ID: 37552"
echo "$LINE"
echo "System Information"
echo "$LINE"
echo "Username: $(whoami)"
echo "Hostname: $(hostname)"
echo "Current Date: $(date)"
echo "Operating System: $(uname -s) $(uname -r)"
echo "Disk Usage:"
df -h /
echo "Memory Usage:"
free -h
echo "$LINE"

if [ -f "$INFO_FILE" ]; then
    echo "Student information file exists."
else
    echo "Student information file does not exist."
fi
