#!/bin/bash


OUTPUT_DIR=dump/local_$(date +'%Y_%m_%d_%H_%M_%S')
DUMP_VOLUME=/sanshin/dump
# OUTPUT_DIR_DOCKER=/sanshin/dump/local_$(date +'%Y_%m_%d_%H_%M_%S')

OUTPUT_FILENAME="dump.json"
OUTPUT_MEDIA_FILENAME="media"
OUTPUT_STATIC_FILENAME="static"
OUTPUT_SQL_DUMP="sqldump.sql"


# the order has to be correct!!
ALL_PLUGINS="auth cms \
menus \
sekizai \
treebeard \
djangocms_text_ckeditor \
filer \
easy_thumbnails \
djangocms_admin_style \
djangocms_column \
djangocms_link \
cmsplugin_filer_file \
cmsplugin_filer_folder \
cmsplugin_filer_image \
cmsplugin_filer_utils \
djangocms_style \
djangocms_snippet \
djangocms_googlemap \
djangocms_video \
aldryn_bootstrap3 \
django_nyt \
mptt \
wiki"

# these lead to errors:
# django.contrib.auth
# django.contrib.contenttypes
# django.contrib.sessions
# django.contrib.admin
# django.contrib.sites
# django.contrib.sitemaps
# django.contrib.staticfiles
# django.contrib.messages
# django.contrib.humanize
# sorl.thumbnail
# wiki.plugins.attachments
# wiki.plugins.notifications
# wiki.plugins.images
# wiki.plugins.macros

mkdir -p "$OUTPUT_DIR"

echo "create '$OUTPUT_DIR/$OUTPUT_FILENAME'..."
docker-compose run --volume "$(pwd)/$OUTPUT_DIR:$DUMP_VOLUME" web bash -c "echo $DUMP_VOLUME/$OUTPUT_FILENAME && python manage.py dumpdata --natural-foreign --exclude auth.permission --exclude contenttypes --output '$DUMP_VOLUME/$OUTPUT_FILENAME' $ALL_PLUGINS"

# echo "saving sql dump to '$OUTPUT_DIR/$OUTPUT_SQL_DUMP'..."
# pg_dump -U $DB_USER > "$OUTPUT_DIR/$OUTPUT_SQL_DUMP"

echo "saving media dir to '$OUTPUT_DIR/$OUTPUT_MEDIA_FILENAME'..."
rsync -r src/sanshin/media/ "$OUTPUT_DIR/$OUTPUT_MEDIA_FILENAME"

echo "saving static dir to '$OUTPUT_DIR/$OUTPUT_STATIC_FILENAME'..."
rsync -r src/sanshin/static/ "$OUTPUT_DIR/$OUTPUT_STATIC_FILENAME"
