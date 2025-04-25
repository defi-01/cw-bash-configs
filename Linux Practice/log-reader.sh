#!/bin/bash

NGINX_PID=$(pgrep -o nginx)

if [ -z "${NGINX_PID}" ]; then
  exit 1
fi

LOG_FD=$(ls -l /proc/${NGINX_PID}/fd 2>/dev/null | grep 'access.log (deleted)' | awk '{print $9}' | sed 's#/proc/'"${NGINX_PID}"'/fd/##')

if [ -z "${LOG_FD}" ]; then
  exit 1
fi

sudo cat /proc/${NGINX_PID}/fd/${LOG_FD}