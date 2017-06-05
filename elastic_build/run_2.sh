#!/usr/bin/sh

# Build custom docker image
docker build --tag=elasticsearch-custom .

# The vm_max_map_count kernel setting needs to be set to at least 262144 for use
sudo sysctl -w vm.max_map_count=262144

docker-compose up -d

