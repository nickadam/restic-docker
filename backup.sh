#!/bin/sh

if [ $TARGZ -eq 1 ]
then
  mkdir /tmp/data 2>/dev/null
  tar -czf /tmp/data/data.tar.gz /data 2>/dev/null
  restic --verbose backup /tmp/data
  rm /tmp/data/data.tar.gz
else
  restic --verbose backup /data
fi
