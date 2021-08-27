#!/bin/sh
set -e
script=$(readlink -f "$0")
script_path=$(dirname "$script")

source ${script_path}/build_bullseye_test.sh
source ${script_path}/build_buster_test.sh
source ${script_path}/build_stretch_test.sh
