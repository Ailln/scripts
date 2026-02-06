SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
[ -f "$SCRIPT_DIR/.env" ] && source "$SCRIPT_DIR/.env"

docker run -d --restart=always \
  --name redis-local \
  -p ${REDIS_PORT:-6379}:6379 \
  -v $HOME/data/redis:/data \
  redis:${REDIS_VERSION:-7.2.4} redis-server \
  --requirepass ${REDIS_PASSWORD:-123456} --save 60 1 --loglevel warning
