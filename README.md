# aoirint_mcping_server

## Feature

- Monitoring status of multiple Minecraft Bedrock/Java servers
- Persistence by PostgreSQL database
- Web API with Read/Write API key authentication

## Supported Minecraft server versions

- Bedrock 1.19.x
- Java 1.19.x

## Deploy

### Docker Compose

Copy these files to a new directory and configure.

- `docker-compose.yml`
- `template.env` -> `.env`

Start Docker Compose services.

```shell
docker compose up -d
```

Then, [apply database migrations](#database-migration).

## Docker repository

- [aoirint/aoirint_mcping_server_web_api](https://hub.docker.com/r/aoirint/aoirint_mcping_server_web_api)
- [aoirint/aoirint_mcping_server_java_updater](https://hub.docker.com/r/aoirint/aoirint_mcping_server_java_updater)
- [aoirint/aoirint_mcping_server_bedrock_updater](https://hub.docker.com/r/aoirint/aoirint_mcping_server_bedrock_updater)

## Database migration

This repository uses [golang-migrate](https://github.com/golang-migrate/migrate).

To apply the migrations,

```shell
docker compose run --rm migrate -path=/migrations -database="postgres://postgres:postgres_password@postgres:5432/postgres?sslmode=disable" up
```

## Library management

This repository uses [Poetry](https://github.com/python-poetry/poetry).

To dump `requirements*.txt`,

```shell
poetry export --without-hashes --with web-api -o requirements-web-api.txt
poetry export --without-hashes --with bedrock-updater -o requirements-bedrock-updater.txt
poetry export --without-hashes --with java-updater -o requirements-java-updater.txt
poetry export --without-hashes --with dev,web-api,bedrock-updater,java-updater -o requirements-dev.txt
```
