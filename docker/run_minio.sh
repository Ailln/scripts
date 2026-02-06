SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
[ -f "$SCRIPT_DIR/.env" ] && source "$SCRIPT_DIR/.env"

docker run -d --restart=always \
  --name minio-local \
  -p ${MINIO_API_PORT:-9000}:9000 -p ${MINIO_CONSOLE_PORT:-9001}:9001 \
  -v $HOME/data/minio:/data \
  -e MINIO_ROOT_USER=${MINIO_ROOT_USER:-root} \
  -e MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD:-12345678} \
  minio/minio:${MINIO_VERSION:-RELEASE.2024-10-13T13-34-11Z} \
  server --console-address ":9001" /data
