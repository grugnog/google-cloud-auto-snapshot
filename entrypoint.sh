#!/bin/bash
# run google-cloud-auto-snapshot.sh in a loop with a configurable delay
# ($SLEEP environment variable) and a notification command 
# ($NOTIFY_COMMAND environment variable), for example a curl webhook
# notification (e.g. to Slack).
if [ -z "${SLEEP}" ]; then
  # Default to every 6 hours
  SLEEP=21600
fi
while true; do
  /opt/google-cloud-auto-snapshot.sh
  if [ -n "${NOTIFY_COMMAND}" ]; then
    echo "Running notify command: $NOTIFY_COMMAND"
    bash -c "$NOTIFY_COMMAND"
  fi
  echo "Sleeping for $SLEEP seconds"
  sleep $SLEEP
done
