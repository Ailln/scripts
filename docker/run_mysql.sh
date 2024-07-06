docker run -d --restart=always --name mysql \
  -p 3306:3306 -v /root/data/mysql:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=123456 \
  mysql:8.0.38 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci