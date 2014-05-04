#!/bin/bash

# Fail hard and fast
set -eo pipefail

export PORT=${PORT:-5000}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD=$HOST_IP:4001

echo "[app] container booted. PORT: $PORT. HOST_IP: $HOST_IP. ETCD: $ETCD"

# Update all logstash-forwarder templates
echo "[app] updating logstash-forwarder config files"
confd -onetime -node $ETCD

# Start logstash-forwarder and background it
logstash-forwarder -config /etc/logstash-forwarder.json &

echo "[app] logstash-forwarder is running"

echo "[app] starting foreman..."
cd /opt/app && foreman start
