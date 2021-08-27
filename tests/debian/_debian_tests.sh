#!/bin/sh
set -e
script=$(readlink -f "$0")
script_path=$(dirname "$script")

source ${script_path}/debian_bullseye_test.sh
source ${script_path}/debian_buster_test.sh
source ${script_path}/debian_stretch_test.sh
source ${script_path}/debian_jessie_test.sh
#source ${script_path}/debian_wheezy_test.sh
