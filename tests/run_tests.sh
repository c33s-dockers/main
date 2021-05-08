#!/bin/sh
set -e
script=$(readlink -f "$0")
script_path=$(dirname "$script")

sh ${script_path}/debian/_debian_tests.sh
sh ${script_path}/php/_php_tests.sh
sh ${script_path}/build/_build_tests.sh
