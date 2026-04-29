# SCRIPTS

🚀 a lot of scripts.

## Table of Contents

```
├── docker
│   ├── run_litellm.sh
│   ├── run_minio.sh
│   ├── run_mongodb.sh
│   ├── run_mysql.sh
│   ├── run_postgres.sh
│   └── run_redis.sh
└── dockerfile
    ├── golang.dockerfile
    ├── golang_dev.dockerfile
    ├── python.dockerfile
    ├── python_dev.dockerfile
    └── nodejs.dockerfile
```

## Docker Scripts

Docker scripts load `docker/.env` automatically when it exists. Copy `docker/.env.example` to `docker/.env` and adjust ports, passwords, and image versions as needed.

```bash
cp docker/.env.example docker/.env
sh docker/run_litellm.sh
```

## License

MIT License.
