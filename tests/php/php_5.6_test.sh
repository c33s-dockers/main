#!/bin/sh
script=$(readlink -f "$0")
script_path=$(dirname "$script")
echo "#################################################################################################################"
echo "### running $(basename ${script} .sh)"
echo "#################################################################################################################"
docker build --file php/base/Dockerfile-5.6 ./php/base
