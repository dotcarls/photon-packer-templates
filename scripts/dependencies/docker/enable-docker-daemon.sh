#!/bin/sh
mkdir -p /etc/docker
echo '{"dns": ["10.0.2.3", "8.8.8.8"] }' >> /etc/docker/daemon.json
systemctl enable docker