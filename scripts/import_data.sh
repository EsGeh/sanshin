#!/bin/bash

JSON_DUMP=sanshin-dump/production_2017_08_29_11_48_00.json

DUMP_DIR=dump
DUMP_VOLUME=/sanshin/dump

function print_help {
	echo -e "usage: $0 [OPTIONS...] [JSON_DUMP]"
	echo
	echo "imports a data snapshot"
	echo
	echo -e "arguments:"
	echo -e "\tJSON_DUMP: location of database dump in $DUMP_DIR"
}

while [[ $# > 0 ]]; do
	i="$1"
	case $i in
		--help)
			print_help
			exit 0
			;;
		-*)
			print_help
			exit 1
			;;
		*)
			break
			;;
	esac
done

if [[ "$#" == 1 ]]; then
	JSON_DUMP="$1"
else
	print_help
	exit 1
fi


docker-compose run \
	--volume "$(pwd)/$DUMP_DIR:$DUMP_VOLUME" web bash -c "python manage.py loaddata $DUMP_VOLUME/$JSON_DUMP"
