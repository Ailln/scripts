docker run -d --restart=always --name redis \
  -p 6379:6379 -v /root/data/redis:/data \
  redis:7.2.4 redis-server \
  --requirepass 123456 --save 60 1 --loglevel warning