SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
[ -f "$SCRIPT_DIR/.env" ] && source "$SCRIPT_DIR/.env"

docker run -d --restart=always \
  --name mongodb-local \
  -p ${MONGODB_PORT:-27017}:27017 \
  -v $HOME/data/mongodb:/data/db \
  -e MONGO_INITDB_ROOT_USERNAME=${MONGO_INITDB_ROOT_USERNAME:-root} \
  -e MONGO_INITDB_ROOT_PASSWORD=${MONGO_INITDB_ROOT_PASSWORD:-123456} \
  mongo:${MONGODB_VERSION:-7.0.12-jammy}
