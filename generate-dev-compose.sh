#!/bin/bash

GARLICOINPATH="${1/#\~/$HOME}"

usage() {
    echo "Usage: sh generate-dev-compose.sh /path/to/garlicoin"
}

reset_file() {
    [ -e $1 ] && rm $1
}

generate_compose() {
    local fn=dev-compose.yml
    reset_file $fn
    echo "version: \"3\"" >> $fn
    echo "services:" >> $fn
    echo "  development:" >> $fn
    echo "    build: development" >> $fn
    echo "    volumes:" >> $fn
    echo "      - ${GARLICOINPATH}:/garlicoin" >> $fn
    echo "    entrypoint: sh /entrypoint.sh" >> $fn
}

generate_dockerfile() {
    local fn=development/Dockerfile
    reset_file $fn
    echo "FROM debian:stable-slim" >> $fn
    echo "" >> $fn
    echo "RUN useradd -r garlicoin    \\" >> $fn
    echo "    && mkdir /garlicoin     \\" >> $fn
    echo "    && apt-get update -y    \\" >> $fn
    echo "    && apt-get install -y   \\" >> $fn
    echo "        git                 \\" >> $fn
    echo "        build-essential     \\" >> $fn
    echo "        libtool             \\" >> $fn
    echo "        autotools-dev       \\" >> $fn
    echo "        automake            \\" >> $fn
    echo "        pkg-config          \\" >> $fn
    echo "        libssl-dev          \\" >> $fn
    echo "        libevent-dev        \\" >> $fn
    echo "        bsdmainutils        \\" >> $fn
    echo "        libboost-all-dev    \\" >> $fn
    echo "    && apt-get clean" >> $fn
    echo "COPY ./entrypoint.sh /" >> $fn
}

generate_entrypoint() {
    local fn=development/entrypoint.sh
    cp release/entrypoint.sh $fn
}

generate() {
    mkdir -p development
    generate_compose
    generate_dockerfile
    generate_entrypoint
}

if [ $# -ne 1 ]; then
    usage
else
    generate
fi