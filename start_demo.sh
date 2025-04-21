#!/bin/bash

handle_error() {
    echo "Error: $1"
    exit 1
}

echo "Building malicious binary..."
if ! cargo build --release; then
    handle_error "Failed to build the Rust binary."
fi

echo "Building Docker image (this might take a long time)..."
if ! docker build -t backdoor_demo . >/dev/null 2>&1; then
    handle_error "Failed to build the Docker image."
fi

echo "Starting Docker image..."
echo -e "\tYou can connect through SSH with the following credentials:"
echo -e "\tUsername: toor"
echo -e "\tPassword: a"
echo -e "\tThen type 'sudo su' to start the challenge."
if ! docker run backdoor_demo; then
    handle_error "Failed to run the Docker container."
fi
