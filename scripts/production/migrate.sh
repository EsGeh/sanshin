#!/bin/bash

source env/bin/activate

export DJANGO_SETTINGS_MODULE=sanshin.settings.production

cd src
python manage.py makemigrations
python manage.py migrate
