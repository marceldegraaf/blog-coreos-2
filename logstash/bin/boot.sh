#!/bin/bash

# Fail hard and fast
set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD=$HOST_IP:4001

echo "[logstash] booting container. ETCD: $ETCD"

# Loop until confd has updated the logstash config
until confd -onetime -node $ETCD -config-file /etc/confd/conf.d/logstash.toml; do
  echo "[logstash] waiting for confd to refresh logstash.conf (waiting for ElasticSearch to be available)"
  sleep 5
done

# Create a new SSL certificate
openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout /opt/logstash/ssl/logstash-forwarder.key -out /opt/logstash/ssl/logstash-forwarder.crt

# Publish SSL cert/key to etcd
curl -L $ETCD/v2/keys/logstash/ssl_certificate -XPUT --data-urlencode value@/opt/logstash/ssl/logstash-forwarder.crt
curl -L $ETCD/v2/keys/logstash/ssl_private_key -XPUT --data-urlencode value@/opt/logstash/ssl/logstash-forwarder.key

# Start logstash
echo "[logstash] starting logstash agent..."
/opt/logstash/bin/logstash agent -f /etc/logstash.conf
