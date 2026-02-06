SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
[ -f "$SCRIPT_DIR/.env" ] && source "$SCRIPT_DIR/.env"

docker run -d --restart=always \
  --name postgres-local \
  -p ${POSTGRES_PORT:-5432}:5432 \
  -v $HOME/data/postgres:/var/lib/postgresql/data \
  -e POSTGRES_USER=${POSTGRES_USER:-postgres} \
  -e POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-123456} \
  -e POSTGRES_DB=${POSTGRES_DB:-mydb} \
  postgres:${POSTGRES_VERSION:-17.4-bookworm}
