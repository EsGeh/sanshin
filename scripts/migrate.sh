#!/bin/bash

docker-compose run web bash -c "sleep 20 && python manage.py makemigrations && python manage.py migrate"
