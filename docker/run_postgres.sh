docker run -d --restart=always --name postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=123456 \
  -e POSTGRES_DB=mydb \
  -p 5432:5432 \
  -v /root/data/postgres:/var/lib/postgresql/data \
  postgres:17.2-bookworm
