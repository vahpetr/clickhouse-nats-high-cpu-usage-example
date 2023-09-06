CREATE TABLE IF NOT EXISTS bus_events_queue (
    time DateTime('UTC'),
    type String,
    message String
) ENGINE = NATS
    SETTINGS
    nats_url = 'nats://bus:4222',
    nats_subjects = 'bus.events.>',
    nats_queue_group = 'db',
    nats_format = 'Protobuf',
    nats_schema = 'bus.proto:Event',
    nats_max_reconnect = 2147483647,
    nats_reconnect_wait = 1000,
    nats_startup_connect_tries = 2147483647,
    nats_max_rows_per_message = 1000,
    nats_max_block_size = 1000;

CREATE TABLE IF NOT EXISTS bus_events (
    time DateTime('UTC'),
    type String,
    message String
) ENGINE = MergeTree()
    PARTITION BY toYYYYMM(time)
    ORDER BY (time, type);

CREATE MATERIALIZED VIEW IF NOT EXISTS consumer TO bus_events
    AS SELECT time, type, message
    FROM bus_events_queue;
