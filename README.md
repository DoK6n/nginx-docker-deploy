# Nginx와 Docker-Compose로 무중단 배포

Nginx의 upsteam을 이용한 로드밸런싱으로 무중단 배포

```javascript
upstream docker-upstream {
  least_conn;
  server DockerContainerIP:PORT;
  server DockerContainerIP:PORT;
  keepalive 256;
}

server {
  listen 80;
  server_name _;

  location / {
    proxy_pass http://docker-upsteam;
    proxy_http_version 1.1;

    proxy_set_header ...
  }
}
```

## Load Balancing Methods

**round-robin**  
- 애플리케이션 서버에 대한 요청이 라운드 로빈 방식으로 분산됨  

**least-connected**  
- 다음 요청은 활성 연결 수가 가장 적은 서버에 할당됨  

**ip-hash**  
- 해시 함수는 클라이언트의 IP 주소를 기반으로 다음 요청을 위해 어떤 서버를 선택해야 하는지 결정하는 데 사용됨

**server**  
- 로드밸런싱을 적용할 도커 컨테이너의 IP와 PORT  
- 컨테이너 IP 조회  
  - `docker inspect -f "{{ .NetworkSettings.IPAddress }}" CONTAINER_NAME`

**keepalive**  
- 접속에 사용될 connection 수  
- 각 worker process에서 cache 하고 있으며 최대 수에 도달하면 가장 최근에 사용된 connection이 closed 된다.

---
# Deploy 과정

1. 블루서버만 실행중
2. 그린서버 배포중
3. 배포시 nginx의 로드밸런싱으로 잠시동안 블루 그린에 모두 로드밸런싱
4. 그린서버 실행중
5. 블루서버 종료하고, 로드밸런싱 설정에 의해 모든 트래픽을 그린서버에서 처리

```bash
# 현재 서버가 green 일 경우
docker-compose -f docker-compose.green.yml down
sleep 10
docker-compose -f docker-compose.blue.yml up -d --build

# 현재 서버가 blue 일 경우
docker-compose -f docker-compose.blue.yml down
sleep 10
docker-compose -f docker-compose.green.yml up -d --build
```
