#!/bin/bash

cid="$(sudo docker ps -q)"

#first deploy
if [ -z "$cid" ]; then
  echo '\n실행중인 컨테이너 없음\n'
  echo '⬆️  ⬆️  ⬆️  ⬆️  blue server up ⬆️  ⬆️  ⬆️  ⬆️ '
  sudo docker-compose -f docker-compose.blue.yml up -d --build
  echo 'deploy done! ✅'
  sudo docker ps
else
  if sudo docker ps --format '{{.Names}}' | grep -Eq "^nodegreen\$"; then
    # if current server [green]
    echo '⬆️  ⬆️  ⬆️  ⬆️  blue server up ⬆️  ⬆️  ⬆️  ⬆️ '
    sudo docker-compose -f docker-compose.blue.yml up -d --build
    sleep 0.2

    echo '⬇️  ⬇️  ⬇️  ⬇️  green server stop ⬇️  ⬇️  ⬇️  ⬇️ '
    sudo docker-compose -f docker-compose.green.yml stop nodegreen
    echo 'deploy done! ✅'
    sudo docker ps -a
  else
    # if current server [blue]
    echo '⬆️  ⬆️  ⬆️  ⬆️  green server up ⬆️  ⬆️  ⬆️  ⬆️ '
    sudo docker-compose -f docker-compose.green.yml up -d --build
    sleep 0.2

    echo '⬇️  ⬇️  ⬇️  ⬇️  blue server stop ⬇️  ⬇️  ⬇️  ⬇️ '
    sudo docker-compose -f docker-compose.blue.yml stop nodeblue
    echo 'deploy done! ✅'
    sudo docker ps -a
  fi
fi 
