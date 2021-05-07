#!/bin/sh
set -e
script=$(readlink -f "$0")
script_path=$(dirname "$script")

#source ./debian.sh
source ${script_path}/php.sh
#source ./build.sh
