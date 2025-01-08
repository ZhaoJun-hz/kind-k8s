#!/usr/bin/env sh
trap "echo break; exit 1" SIGINT

while true
do
  echo starting nginx
  sed -i "s/__PORT__/$PORT/g" /etc/nginx/conf.d/default.conf
  nginx -g "daemon off;"
done
