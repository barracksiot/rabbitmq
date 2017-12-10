#!/bin/bash
set -e

function setConfiguration() {
  KEY=$1
  VALUE=$2
  sed -i "s/\_\_$KEY\_\_/$VALUE/g" /etc/rabbitmq/rabbitmq.config
  sed -i "s/\_\_$KEY\_\_/$VALUE/g" /etc/rabbitmq/definitions.json
}

if [ -n "${VHOST_INTERNAL_USERNAME+1}" ]; then
  setConfiguration "VHOST_INTERNAL_USERNAME" "$VHOST_INTERNAL_USERNAME"
else
  echo "VHOST_INTERNAL_USERNAME is needed."
  exit 1
fi

if [ -n "${VHOST_DEFAULT_USERNAME+1}" ]; then
  setConfiguration "VHOST_DEFAULT_USERNAME" "$VHOST_DEFAULT_USERNAME"
else
  echo "VHOST_DEFAULT_USERNAME is needed."
  exit 1
fi

if [ -n "${VHOST_INTERNAL_PASSWORD+1}" ]; then
  setConfiguration "VHOST_INTERNAL_PASSWORD" "$VHOST_INTERNAL_PASSWORD"
else
  echo "VHOST_INTERNAL_PASSWORD is needed."
  exit 1
fi

if [ -n "${VHOST_DEFAULT_PASSWORD+1}" ]; then
  setConfiguration "VHOST_DEFAULT_PASSWORD" "$VHOST_DEFAULT_PASSWORD"
else
  echo "VHOST_DEFAULT_PASSWORD is needed."
  exit 1
fi

if [ -n "${IO_BARRACKS_RABBITMQAUTHSERVICE_BASE_URL+1}" ]; then
  setConfiguration "IO_BARRACKS_RABBITMQAUTHSERVICE_BASE_URL" "$IO_BARRACKS_RABBITMQAUTHSERVICE_BASE_URL"
else
  echo "IO_BARRACKS_RABBITMQAUTHSERVICE_BASE_URL is needed."
  exit 1
fi

if [ "$1" = 'rabbitmq-server' ]; then
    exec rabbitmq-server "$@"
fi

exec "$@"