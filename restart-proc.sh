#!/bin/sh

FILENAME=/tmp/restart-service.tmp
while [ true ]
do
   sleep 1
   if [ -f $FILENAME ]; then
      echo "Restarting service and removing $FILENAME"
      rm /tmp/restart-service.tmp
      serf event RESTARTED
   fi
done
