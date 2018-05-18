#!/bin/sh

#Setup environment variables to redis and elastic
GRAVITEEIO_REDISDB_HOST=$(/opt/zookeeper-cli-1.4/bin/zk -c "get -s /spai/gravitee/redisdb_host" "$ZOOKEEPER_HOST":"$ZOOKEEPER_PORT" | tail -n +2)
GRAVITEEIO_REDISDB_PORT=$(/opt/zookeeper-cli-1.4/bin/zk -c "get -s /spai/gravitee/redisdb_port" "$ZOOKEEPER_HOST":"$ZOOKEEPER_PORT" | tail -n +2)
GRAVITEEIO_ELASTIC_HOST=$(/opt/zookeeper-cli-1.4/bin/zk -c "get -s /spai/gravitee/elastic_host" "$ZOOKEEPER_HOST":"$ZOOKEEPER_PORT" | tail -n +2)
GRAVITEEIO_ELASTIC_PORT=$(/opt/zookeeper-cli-1.4/bin/zk -c "get -s /spai/gravitee/elastic_port" "$ZOOKEEPER_HOST":"$ZOOKEEPER_PORT" | tail -n +2)

echo "export GRAVITEEIO_REDISDB_HOST=$GRAVITEEIO_REDISDB_HOST" >> /etc/profile.d/gravitee-env.sh
echo "export GRAVITEEIO_REDISDB_PORT=$GRAVITEEIO_REDISDB_PORT" >> /etc/profile.d/gravitee-env.sh
echo "export GRAVITEEIO_ELASTIC_HOST=$GRAVITEEIO_ELASTIC_HOST" >> /etc/profile.d/gravitee-env.sh
echo "export GRAVITEEIO_ELASTIC_PORT=$GRAVITEEIO_ELASTIC_PORT" >> /etc/profile.d/gravitee-env.sh

chmod +x /etc/profile.d/gravitee-env.sh
source /etc/profile
