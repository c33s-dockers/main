#!/usr/bin/env bash

version_compare_lte() {
    [  "$1" = "`echo -e "$1\n$2" | sort --version-sort | head -n1`" ]
}

version_compare_lt() {
    [ "$1" = "$2" ] && return 1 || version_compare_lte $1 $2
}

version_compare_gte() {
    [  "$1" = "`echo -e "$1\n$2" | sort --version-sort --reverse | head -n1`" ]
}

version_compare_gt() {
    [ "$1" = "$2" ] && return 1 || version_compare_gte $1 $2
}

version_compare_lte "7.0" "5.6" && echo "yes" || echo "no"
version_compare_lte "7.0" "7.0" && echo "yes" || echo "no"
version_compare_lte "7.0" "7.2" && echo "yes" || echo "no"
echo "---"
version_compare_lt "7.0" "5.6" && echo "yes" || echo "no"
version_compare_lt "7.0" "7.0" && echo "yes" || echo "no"
version_compare_lt "7.0" "7.2" && echo "yes" || echo "no"
echo "---"
version_compare_gte "7.0" "5.6" && echo "yes" || echo "no"
version_compare_gte "7.0" "7.0" && echo "yes" || echo "no"
version_compare_gte "7.1" "7.0" && echo "yes" || echo "no"
version_compare_gte "7.0" "7.2" && echo "yes" || echo "no"
echo "---"
version_compare_gt "7.0" "5.6" && echo "yes" || echo "no"
version_compare_gt "7.0" "7.0" && echo "yes" || echo "no"
version_compare_gt "7.0" "7.2" && echo "yes" || echo "no"
echo "---"

#PHP_VERSION="7.2"
#if version_compare_lte "$PHP_VERSION" "7.2" && version_compare_gt "$PHP_VERSION" "7.0"; then
#    echo "yes"
#else
#    echo "no"
#fi
#
#if version_compare_lte "$PHP_VERSION" "7.2"; then
#    echo "yes"
#else
#    echo "no"
#fi
#if version_compare_gt "$PHP_VERSION" "7.0"; then
#    echo "yes"
#else
#    echo "no"
#fi
