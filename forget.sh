#!/bin/sh

# prevent backup and forget from running at the same time
sleep 3

# wait for backup
while pgrep restic >/dev/null || pgrep tar >/dev/null
do
  sleep 1
done

restic forget ${FORGET_ARGS}
