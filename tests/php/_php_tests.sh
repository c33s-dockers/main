#!/bin/sh
set -e
script=$(readlink -f "$0")
script_path=$(dirname "$script")

source ${script_path}/php_8.0_test.sh
source ${script_path}/php_7.4_test.sh
source ${script_path}/php_7.3_test.sh
source ${script_path}/php_7.2_test.sh
source ${script_path}/php_7.1_test.sh
source ${script_path}/php_7.0_test.sh
source ${script_path}/php_5.6_test.sh
