docker run -d --restart=always \
  --name minio-local \
  -p 9000:9000 -p 9001:9001 \
  -v $HOME/data/minio:/data \
  -e MINIO_ROOT_USER=root \
  -e MINIO_ROOT_PASSWORD=12345678 \
  minio/minio:RELEASE.2024-10-13T13-34-11Z \
  server --console-address ":9001" /data
