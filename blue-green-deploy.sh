if sudo docker ps --format '{{.Names}}' | grep -Eq "^nodegreen\$"; then
  # if current server is green
  echo '⬆️  ⬆️  ⬆️  ⬆️  blue server up ⬆️  ⬆️  ⬆️  ⬆️ '
  sudo docker-compose -f docker-compose.blue.yml up -d --build
  sleep 1

  echo '⬇️  ⬇️  ⬇️  ⬇️  green server down ⬇️  ⬇️  ⬇️  ⬇️ '
  sudo docker-compose -f docker-compose.green.yml down
  echo 'deploy done! ✅'
  sudo docker ps
else
  # if current server is blue
  echo '⬆️  ⬆️  ⬆️  ⬆️  green server up ⬆️  ⬆️  ⬆️  ⬆️  '
  sudo docker-compose -f docker-compose.green.yml up -d --build
  sleep 1

  echo '⬇️  ⬇️  ⬇️  ⬇️  blue server down ⬇️  ⬇️  ⬇️  ⬇️ '
  sudo docker-compose -f docker-compose.blue.yml down
  echo 'deploy done! ✅'
  sudo docker ps
fi

# first deploy
#if [ -n / $(sudo docker ps -q) ]; then
#  echo '\n실행중인 컨테이너 없음\n'
#  echo '⬆️  ⬆️  ⬆️  ⬆️  blue server up ⬆️  ⬆️  ⬆️  ⬆️ '
#  sudo docker-compose -f docker-compose.blue.yml up -d --build
#  echo 'deploy done! ✅'
#  sudo docker ps
#fi
