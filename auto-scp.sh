#!/bin/bash

#YOUR REMOTE SSH INFORMATION
USERNAME="<SERVER_USERNAME>"
IP="<SERVER_IP>"
PORT="<SSH_PORT>"

#CHECK PORT IF IS NOT EMPTY ADD -P OPTION
if [ ! -z $PORT ]; then
  PORT="-P $PORT"
fi

#GET LOCAL DIRECTORY PATH AND REMOTE DIRECTORY PATH
LOCAL_PATH_FILE=$1
REMOTE_PATH_FILE=$2

#CHECK LOCAL PATH AND REMOTE PATH NOT EMPTY
if [ -z "$LOCAL_PATH_FILE" -o -z "$REMOTE_PATH_FILE" ]; then
  echo "We need 2 argumans <directory to check on local> <remote path to copy>"
  exit
fi

C=0

inotifywait -r -e delete -e create -e modify -m -q --format '%e %w %f' $LOCAL_PATH_FILE | while read FILE
do
  #inotifywait RUN TWICE FOR AN EVENT WE IGNORE ONE Of THEM
  if [[ $C = 1 ]]; then
    C=0
    continue
  else
    ((C++))
  fi

  LIST=($FILE)

  #DO WHAT WE WANT ACCORDING TO EVENTS
  if [ ${LIST[0]} = 'MODIFY' ]; then
    scp $PORT ${LIST[1]}${LIST[2]} $USERNAME@$IP:$REMOTE_PATH_FILE
  elif [ ${LIST[0]} = 'DELETE' ]; then
    echo "SOME FILE DELETED"
  elif [ ${LIST[0]} = 'CREATE' ]; then
    scp $PORT ${LIST[1]}${LIST[2]} $USERNAME@$IP:$REMOTE_PATH_FILE
  fi
  #HERE IS WHAT YOU WANT TO PUT FOR NOTIFICATION
  ( speaker-test -t sine -f 1000 > /dev/null)& pid=$! ; sleep 0.1s ; kill -9 $pid > /dev/null
done
