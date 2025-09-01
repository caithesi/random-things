#!/bin/bash

# Usage: ./remind.sh 5 "Take a break"
# -> After 5 minutes, will show a notification "Take a break"

if [ $# -lt 2 ]; then
  echo "Usage: $0 <minutes> <message>"
  exit 1
fi

minutes=$1
shift
message="$*"

# Sleep for given minutes in background
(sleep $((minutes * 60)) && notify-send "Reminder" "$message") &