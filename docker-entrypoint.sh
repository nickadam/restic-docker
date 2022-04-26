#!/bin/sh

if [ ! -z "$AWS_SECRET_ACCESS_KEY_FILE" ]
then
  export AWS_SECRET_ACCESS_KEY="$(cat $AWS_SECRET_ACCESS_KEY_FILE)"
fi

if [ ! -z "$RESTIC_PASSWORD_FILE" ]
then
  export RESTIC_PASSWORD="$(cat $RESTIC_PASSWORD_FILE)"
fi

if [ -z "$AWS_ACCESS_KEY_ID" ] ||
  [ -z "$AWS_SECRET_ACCESS_KEY" ] ||
  [ -z "$RESTIC_PASSWORD" ] ||
  [ -z "$RESTIC_REPOSITORY" ] ||
  [ -z "$TARGZ" ] ||
  [ -z "$BACKUP_CRON" ] ||
  [ -z "$FORGET_CRON" ] ||
  [ -z "$FORGET_ARGS" ]
then
  echo "Environment variables must be set"
  exit 1
fi

# init repo
restic snapshots >/dev/null || restic init || exit 1

crond

touch /backup.log /forget.log

echo -e "$BACKUP_CRON /backup.sh 2>&1 >> /backup.log\n$FORGET_CRON /forget.sh 2>&1 >> /forget.log" | crontab -

tail -n 0 -f backup.log forget.log
