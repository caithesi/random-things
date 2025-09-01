#!/bin/bash

# Usage: ./remind.sh 5 "Take a break"
# If you run it again, it cancels the previous reminder and sets the new one.

PIDFILE="$HOME/.remind_pid"

if [ $# -lt 2 ]; then
  echo "Usage: $0 <minutes> <message>"
  exit 1
fi

minutes=$1
shift
message="$*"

# Kill previous reminder if running
if [ -f "$PIDFILE" ]; then
  oldpid=$(cat "$PIDFILE")
  if kill -0 "$oldpid" 2>/dev/null; then
    kill "$oldpid"
  fi
fi

# Start new reminder
(
  sleep $((minutes * 60))
  notify-send "Reminder" "$message"
) &

# Save its PID
echo $! > "$PIDFILE"
