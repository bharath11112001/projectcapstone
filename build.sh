
#!/bin/bash
docker build -t mynginximg .
docker run mynginximg -d -p 3000:80 mynginximg
docker-compose up -d





