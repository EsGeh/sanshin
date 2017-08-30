#!/bin/bash

DUMP_DIR=
DUMP_FILENAME="dump.json"
DUMP_MEDIA_FILENAME="media"
DUMP_STATIC_FILENAME="static"
DUMP_SQL_DUMP="sqldump.sql"

function print_help {
	echo -e "usage: $0 [OPTIONS...] DUMP_DIR"
	echo
	echo "imports a data snapshot"
	echo
	echo -e "arguments:"
	echo -e "\tDUMP_DIR location of dump"
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
	DUMP_DIR="$1"
else
	print_help
	exit 1
fi

source env/bin/activate

export DJANGO_SETTINGS_MODULE=sanshin.settings.production

cd src
python manage.py loaddata "$DUMP_DIR/$DUMP_FILENAME"

rsync -r "$DUMP_DIR/$DUMP_MEDIA_FILENAME" sanshin/media
rsync -r "$DUMP_DIR/$DUMP_STATIC_FILENAME" sanshin/static
