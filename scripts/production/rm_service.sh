#!/bin/bash

SERVICE_NAME=gunicorn

cd ~/service/$SERVICE_NAME
rm ~/service/$SERVICE_NAME
svc -dx . log
rm -rf ~/etc/run-$SERVICE_NAME


if [[ $DJANGO_HTACCESS_PATH == "" ]]; then
	echo "WARNING: DJANGO_HTACCESS_PATH is undefined!"
else
	rm -r $(dirname $DJANGO_HTACCESS_PATH)
fi
