#!/bin/bash


# DJANGO_SETTINGS_MODULE=sanshin.settings.production

if [[ $DJANGO_URL == "" ]]; then
	echo "DJANGO_URL is undefined!"
	exit 1
fi

if [[ $DJANGO_PORT == "" ]]; then
	echo "DJANGO_PORT is undefined!"
	exit 1
fi

if [[ $DJANGO_HTACCESS_PATH == "" ]]; then
	echo "DJANGO_HTACCESS_PATH is undefined!"
	exit 1
fi

if netstat -tulpen | grep $DJANGO_PORT &> /dev/null; then
	echo "DJANGO_PORT $DJANGO_PORT is already in use!"
	exit 1
fi

# install uberspace services, if necessary:
if [[ ! -d ~/service ]]; then
	uberspace-setup-svscan
fi


# if not yet running, start the service
if [[ ! -e ~/service/gunicorn ]]; then

	source env/bin/activate
	uberspace-setup-service gunicorn \
		gunicorn \
			--error-logfile - \
			--reload \
			--chdir /home/$USER/sanshin/src \
			--bind 127.0.0.1:$DJANGO_PORT \
			sanshin.wsgi:application

	mkdir -p $(dirname $DJANGO_HTACCESS_PATH)

cat <<__EOF__>$DJANGO_HTACCESS_PATH
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteBase /
RewriteRule ^(.*)$ http://127.0.0.1:$DJANGO_PORT/\$1 [P]
 
RequestHeader set X-Forwarded-Proto https env=HTTPS
__EOF__

else
	echo "service is already running!"
	exit 1
fi
