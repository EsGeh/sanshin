#!/bin/bash

OUTPUT_FILE=~/.django_config


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
__EOF__

echo "created '$OUTPUT_FILE' with the following content:"
cat "$OUTPUT_FILE"
