#!/bin/bash

connect_development() {
	echo "dev"
	docker exec -it garlicoin_development_1 bash
}

connect_release() {
	echo "release"
	docker exec -it garlicoin_release_1 bash
}

print_help() {
	echo "Usage: ./connect.sh -[d|r]"
	echo "  -d : Connect to running development docker machine"
	echo "  -r : Connect to running release docker machine"
}

while getopts "dr" ENV; do
	case $ENV in
		d) connect_development; exit 0;;
		r) connect_release; exit 0;;
		?) print_help; exit 2;;
	esac
done

if [ $# -eq 0 ]; then
	print_help
fi