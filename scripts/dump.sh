#!/bin/bash

docker-compose run web bash -c "python manage.py dumpdata --output /sanshin/dump/dump.json"
