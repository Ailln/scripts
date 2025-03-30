docker run -d --restart=always \
  --name mysql-local \
  -p 3306:3306 \
  -v $HOME/data/mysql:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=123456 \
  mysql:8.0.38 \
  --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
