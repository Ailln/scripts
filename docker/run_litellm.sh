SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
[ -f "$SCRIPT_DIR/.env" ] && source "$SCRIPT_DIR/.env"

docker run -d --restart=always \
  --name litellm-local \
  -p ${LITELLM_PORT:-4000}:4000 \
  -e LITELLM_MASTER_KEY=${LITELLM_MASTER_KEY:-123456} \
  -e DATABASE_URL=${LITELLM_DATABASE_URL:-postgresql://postgres:123456@host.docker.internal:5432/litellm} \
  -e STORE_MODEL_IN_DB=True \
  litellm/litellm:${LITELLM_VERSION:-v1.83.10-stable}
