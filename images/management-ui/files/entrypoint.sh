#!/bin/sh
echo CONFD_NODE : $CONFD_NODE
echo CONFD_PREFIX : $CONFD_PREFIX

cat /etc/hosts
if [ ! -z $CONFD_NODE ]
then
    mv /var/www/html/constants.json /constants.json.ori
    if [ ! -z $CONFD_NODE ]
    then
        /opt/confd/bin/confd -onetime -backend consul -node $CONFD_NODE -prefix="$CONFD_PREFIX" -log-level="debug"
    else
        /opt/confd/bin/confd -onetime -backend consul -node $CONFD_NODE -log-level="debug"
    fi
fi
echo "Gravitee.io APIM Webui is ready."
exec "$@"
