# clickhouse-nats-high-cpu-usage-example

Сейчас при создании подписки на очередь в NATS clickhouse без нагрузки постоянно потребляет 100% cpu.

Ссылка на issue: https://github.com/ClickHouse/ClickHouse/issues/54353

```sh
docker compose up -d
docker stats
```

```sh
docker compose down
```