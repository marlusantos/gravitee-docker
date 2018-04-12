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
FROM nginx:1.12-alpine as build

ARG GRAVITEEIO_VERSION=0
ARG CONFD_VERSION=0.15.0

LABEL maintainer="Gravitee Team <http://gravitee.io>" \
      version="${GRAVITEEIO_VERSION}"

# download Gravitee.io
RUN apk --update add zip unzip bash wget
RUN wget https://download.gravitee.io/graviteeio-apim/distributions/graviteeio-full-${GRAVITEEIO_VERSION}.zip --no-check-certificate -P /tmp/
RUN unzip /tmp/graviteeio-full-${GRAVITEEIO_VERSION}.zip -d /tmp/
RUN mkdir -p /src/app/graviteeio-management-ui
RUN mv /tmp/graviteeio-full-${GRAVITEEIO_VERSION}/graviteeio-management-ui*/* /src/app/graviteeio-management-ui/
# download confd
RUN mkdir -p /src/app/confd
RUN wget https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 --no-check-certificate -P /tmp/
RUN mv /tmp/confd-${CONFD_VERSION}-linux-amd64 /src/app/confd/confd


# CREATE IMAGE
FROM nginx:1.12-alpine

ENV WWW_TARGET /var/www/html/
RUN mkdir -p ${WWW_TARGET}
WORKDIR ${WWW_TARGET}

# copy webui content
COPY --from=build /src/app/graviteeio-management-ui/ ./

# nginx
COPY ./files/nginx.conf /etc/nginx/conf.d/default.conf

# confd
RUN mkdir -p /opt/confd/bin
COPY --from=build /src/app/confd/confd /opt/confd/bin/
RUN chmod +x /opt/confd/bin/confd
RUN mkdir -p /etc/confd/{conf.d,templates}
COPY ./files/confd/*.toml /etc/confd/conf.d/
COPY ./files/confd/*.tmpl /etc/confd/templates/

COPY ./files/entrypoint.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/entrypoint.sh

EXPOSE 80 443
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
