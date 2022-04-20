#!/bin/bash

cid=$(sudo docker ps -q)

if [ -n "$cid" ]; then
  if sudo docker ps --format '{{.Names}}' | grep -Eq "^nodegreen\$"; then
    # current server [green]
    # need rollback [blue]

    echo '⬆️  ⬆️  ⬆️  ⬆️  blue server restart ⬆️  ⬆️  ⬆️  ⬆️ '
    sudo docker-compose -f docker-compose.blue.yml restart nodeblue
    sleep 0.2

    echo '⬇️  ⬇️  ⬇️  ⬇️  green server stop ⬇️  ⬇️  ⬇️  ⬇️ '
    sudo docker compose -f docker-compose.green.yml stop nodegreen
    sleep 0.2

    echo 'blue rollback done! ✅'
    sudo docker ps -a
  else
    # current server [blue]
    # need rollback [green]

    echo '⬆️  ⬆️  ⬆️  ⬆️  green server restart ⬆️  ⬆️  ⬆️  ⬆️ '
    sudo docker-compose -f docker-compose.green.yml restart nodegreen
    sleep 0.2

    echo'⬇️  ⬇️  ⬇️  ⬇️  blue server stop ⬇️  ⬇️  ⬇️  ⬇️ '
    sudo docker compose -f docker-compose.blue.yml stop nodeblue
    sleep 0.2

    echo 'green rollback done! ✅'
    sudo docker ps -a
  fi
fi 
