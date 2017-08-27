#!/bin/bash

python3 -m venv env
source env/bin/activate

# install python packages:
pip install -r requirements.txt

# install postgres if necessary:
if [[ "$PGHOST" == "" ]]; then
	uberspace-setup-postgresql
	echo "please adjust DATABASES in the production settings accordingly"
	createuser -P django
	createdb django
fi

# install a wsgi webserver:
pip install gunicorn
