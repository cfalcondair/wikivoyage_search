#!/usr/bin/sh

# Rebuild temp dir
sudo rm -rf /tmp/wikivoyage/
mkdir -p /tmp/wikivoyage/

# System memory requirements for elasticsearch
sudo sysctl -w vm.max_map_count=262144

docker-compose up --build

