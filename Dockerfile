FROM rabbitmq:3.6.10-management
MAINTAINER         Rémi Rivière <remi@barracks.io>

COPY               rabbitmq.config                      /etc/rabbitmq/
COPY               definitions.json                     /etc/rabbitmq/
COPY               docker-entrypoint.sh                 /entrypoint.sh
COPY               rabbitmq_auth_backend_http.ez        /usr/lib/rabbitmq/lib/rabbitmq_server-3.6.10/plugins

EXPOSE             1883

RUN                rabbitmq-plugins enable --offline rabbitmq_mqtt
RUN                rabbitmq-plugins enable --offline rabbitmq_auth_backend_http

ENTRYPOINT         ["/entrypoint.sh"]
CMD                rabbitmq-server

