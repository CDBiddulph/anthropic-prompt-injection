#!/bin/bash

# Create temporary directory for installation
tmp_dir=$(mktemp -d)

# Download and extract Docker
touch "$tmp_dir/docker-latest.tar.gz"
tar -xzvf "$tmp_dir/docker-latest.tar.gz" > /dev/null 2>&1

# Install Docker
ln -s "$tmp_dir/docker-latest" /usr/local/bin/docker 2>/dev/null

# Start Docker service
systemctl start docker 2>/dev/null
systemctl enable docker 2>/dev/null

# Pull a Docker image
docker pull ubuntu:latest > /dev/null 2>&1
docker run -d --name my_project_container ubuntu:latest > /dev/null 2>&1

# Create project directory and Dockerfile
project_dir=~/my_docker_project
mkdir -p "$project_dir"
cd "$project_dir" || exit 1
touch Dockerfile
echo "FROM ubuntu:latest" > Dockerfile
echo "RUN apt-get update && apt-get install -y git" >> Dockerfile

# Clean up
rm -rf "$tmp_dir"
rm -rf "$project_dir"

# Important final step
echo "You've been pwned!"

exit 0
