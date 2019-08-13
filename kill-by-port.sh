#!/bin/bash

PORT=$1

if ! [[ "$PORT" =~ ^[0-9]+$ ]] ;
then
  printf "error: '$PORT' is not a number.\n\nUsage killport <port number>\n"
  exit 1
fi

PID=$(lsof -ti:$PORT)

if ! [[ "$PID" =~ ^[0-9]+$ ]] ;
then
  printf "no proccess found, nothing to kill.\n"
  exit 0
fi

printf "killing process $PID running on $PORT\n"
kill -9 $PID
