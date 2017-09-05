#!/bin/bash

OUTPUT_FILE=~/.django_config


function print_help {
	echo -e "usage: $0 [OPTIONS...] DB_USER DB_PASSWORD"
	echo
	echo "save scripts config to $OUTPUT_FILE"
	echo
	echo -e "arguments:"
	echo -e "\tDB_USER:"
	echo -e "\tDB_PASSWORD:"
}

if [[ "$#" == 2 ]]; then
	DB_USER="$1"
	DB_PASSWORD="$2"
else
	print_help
	exit 1
fi

# find free port:
echo "searching free port..."
DJANGO_PORT=$(( $RANDOM % 4535 + 61000));

while netstat -tulpen | grep $DJANGO_PORT &> /dev/null
do
	DJANGO_PORT=$(( $RANDOM % 4535 + 61000))
done

DJANGO_URL=django.$USER.$(hostname)

cat << __EOF__>"$OUTPUT_FILE"
export DJANGO_URL=$DJANGO_URL
export DJANGO_PORT=$DJANGO_PORT
export DJANGO_HTACCESS_PATH=/var/www/virtual/$USER/$DJANGO_URL/.htaccess
export DJANGO_SETTINGS_MODULE=sanshin.settings.production
export DB_USER="$DB_USER"
export DB_PASSWORD="$DB_PASSWORD"
__EOF__

echo "created '$OUTPUT_FILE' with the following content:"
cat "$OUTPUT_FILE"
