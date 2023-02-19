# aoirint_mcping

## TODO

- [x] Bedrock server ping
- [x] Prohibit duplicated server registration
- [x] Java server ping
- [x] Restrict write API access

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
