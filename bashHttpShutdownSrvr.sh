#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

PORT=8080

while true; do
  echo -e "HTTP/1.1 200 OK\n\n We'll give that a try" | nc -l -p ${PORT} -q 1 > file.txt
  if [ -f file.txt ]; then
    if ( grep "^GET /shutdown " file.txt); then
      echo SHUTDOWN
      sudo shutdown now
    elif ( grep "^GET /restart " file.txt); then
      echo RESTART
      sudo shutdown -r now
    fi
  fi
done
