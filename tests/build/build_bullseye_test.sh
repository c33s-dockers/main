#!/bin/sh
script=$(readlink -f "$0")
script_path=$(dirname "$script")
echo "#################################################################################################################"
echo "### running $(basename ${script} .sh)"
echo "#################################################################################################################"
docker build --file build/Dockerfile-bullseye ./build
