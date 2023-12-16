#!/bin/bash

# Define a pattern for container names
pattern="webserver-"

# Get a list of container names matching the pattern
container_names=$(docker ps -a --filter "name=${pattern}" --format "{{.Names}}")

# Loop through the container names and remove each container
for container_name in ${container_names}; do
    docker rm -f ${container_name}
done
