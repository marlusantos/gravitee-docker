#-------------------------------------------------------------------------------
# Copyright (C) 2015 The Gravitee team (http://gravitee.io)
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#            http://www.apache.org/licenses/LICENSE-2.0
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#-------------------------------------------------------------------------------
FROM graviteeio/java:8
MAINTAINER Gravitee Team <http://gravitee.io>

ARG GRAVITEEIO_VERSION=0
ARG GRAVITEEIO_REPOSITORY_REDIS_VERSION=0

# Update to get support for Zip/Unzip, nc and wget
RUN apk add --update zip unzip netcat-openbsd wget

RUN wget https://download.gravitee.io/graviteeio-apim/distributions/graviteeio-full-${GRAVITEEIO_VERSION}.zip --no-check-certificate -P /tmp/ \
    && unzip /tmp/graviteeio-full-${GRAVITEEIO_VERSION}.zip -d /tmp/ \
    && mv /tmp/graviteeio-full-${GRAVITEEIO_VERSION}/graviteeio-management-api* /opt/graviteeio-management-api \
    && wget https://download.gravitee.io/graviteeio-apim/plugins/repositories/gravitee-repository-redis/gravitee-repository-redis-${GRAVITEEIO_REPOSITORY_REDIS_VERSION}.zip --no-check-certificate -P /tmp/ \
    && mv /tmp/gravitee-repository-redis-${GRAVITEEIO_REPOSITORY_REDIS_VERSION}.zip /opt/graviteeio-management-api/plugins/ \
    && wget https://oss.sonatype.org/content/groups/public/com/loopfor/zookeeper/zookeeper-cli/1.4/zookeeper-cli-1.4.zip  --no-check-certificate -P /tmp/ \
    && unzip /tmp/zookeeper-cli-1.4.zip -d /tmp/ \
    && mv /tmp/zookeeper-cli-1.4 /opt/ \
    && chmod +x /opt/zookeeper-cli-1.4/bin/zk \
    && rm -rf /tmp/*

ENV GRAVITEEIO_HOME /opt/graviteeio-management-api

WORKDIR ${GRAVITEEIO_HOME}

COPY startup.sh set-env.sh /opt/graviteeio-management-api/bin/

RUN chmod +x /opt/graviteeio-management-api/bin/*

EXPOSE 8083
VOLUME ["/opt/graviteeio-management-api/logs"]
CMD ["sh -l ./bin/startup.sh"]
