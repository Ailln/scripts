docker run -d --restart=always --name mongodb \
  -p 27017:27017 -v /root/data/mongodb:/data/db \
  -e MONGO_INITDB_ROOT_USERNAME=root \
  -e MONGO_INITDB_ROOT_PASSWORD=123456 \
  mongo:7.0.12-jammy
