#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <container_name>"
    exit 1
fi

# Assign the first argument to CONTAINER_NAME
CONTAINER_NAME=$1

# Check if a container with the same name is running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing existing container..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi