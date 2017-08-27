#!/bin/bash

python3 -m venv env
source env/bin/activate

export DJANGO_SETTINGS_MODULE=sanshin.settings.production

cd src
python manage.py loaddata ../dump/dump.json
