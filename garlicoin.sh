#!/bin/bash

FORCE_BUILD=0

print_help() {
    echo "Usage: ./garlicoin.sh -[f] -[c|b] [options]"
    echo "  -c [dev | release] : Connect to running docker machine"
    echo "  -s [dev | release] : Build and/or start and Garlicoin container"
    echo "  -f : Force build when starting docker"
}

parse_connect() {
    if [ $1 == "dev" ]; then
        echo "dev"
        docker exec -it garlicoin_development_1 bash
    elif [ $1 == "release" ]; then
        echo "release"
        docker exec -it garlicoin_release_1 bash
    else
        print_help
        exit 0
    fi
}

parse_start() {
    if [ $1 == "dev" ]; then
        FORCE_BUILD=$FORCE_BUILD docker-compose -f dev-compose.yml up --build
    elif [ $1 == "release" ]; then
        FORCE_BUILD=$FORCE_BUILD docker-compose up --build
    else
        print_help
        exit 0
    fi
}

while getopts "fc:s:" ENV; do
    case $ENV in
        f) FORCE_BUILD=1;;
        c) parse_connect $OPTARG; exit 0;;
        s) parse_start $OPTARG; exit 0;;
        ?) print_help; exit 2;;
    esac
done

if [ $# -eq 0 ]; then
    print_help
fi