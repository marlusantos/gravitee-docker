#!/bin/sh

#Setup environment variables to redis and elastic
GRAVITEEIO_REDISDB_HOST=$(/opt/zookeeper-cli-1.4/bin/zk -c "get -s /spai/gravitee/redisdb_host" "$ZOOKEEPER_HOST":"$ZOOKEEPER_PORT" | tail -n +2)
GRAVITEEIO_REDISDB_PORT=$(/opt/zookeeper-cli-1.4/bin/zk -c "get -s /spai/gravitee/redisdb_port" "$ZOOKEEPER_HOST":"$ZOOKEEPER_PORT" | tail -n +2)
GRAVITEEIO_ELASTIC_HOST=$(/opt/zookeeper-cli-1.4/bin/zk -c "get -s /spai/gravitee/elastic_host" "$ZOOKEEPER_HOST":"$ZOOKEEPER_PORT" | tail -n +2)
GRAVITEEIO_ELASTIC_PORT=$(/opt/zookeeper-cli-1.4/bin/zk -c "get -s /spai/gravitee/elastic_port" "$ZOOKEEPER_HOST":"$ZOOKEEPER_PORT" | tail -n +2)

export GRAVITEEIO_REDISDB_HOST
export GRAVITEEIO_REDISDB_PORT
export GRAVITEEIO_ELASTIC_HOST
export GRAVITEEIO_ELASTIC_PORT
