#!/bin/bash


OUTPUT_DIR=~/sanshin-dump/production_$(date +'%Y_%m_%d_%H_%M_%S')
OUTPUT_FILENAME="dump.json"
OUTPUT_MEDIA_FILENAME="media"
OUTPUT_STATIC_FILENAME="static"
OUTPUT_SQL_DUMP="sqldump.sql"

mkdir -p "$OUTPUT_DIR"

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


source env/bin/activate
cd src

echo "saving django dump to '$OUTPUT_DIR/$OUTPUT_FILENAME'..."
python manage.py dumpdata --natural-foreign --exclude auth.permission --exclude contenttypes --output "$OUTPUT_DIR/$OUTPUT_FILENAME" $ALL_PLUGINS

echo "saving sql dump to '$OUTPUT_DIR/$OUTPUT_SQL_DUMP'..."
pg_dump -U $DB_USER > "$OUTPUT_DIR/$OUTPUT_SQL_DUMP"

echo "saving media dir to '$OUTPUT_DIR/$OUTPUT_MEDIA_FILENAME'..."
rsync -r sanshin/media "$OUTPUT_DIR/$OUTPUT_MEDIA_FILENAME"

echo "saving static dir to '$OUTPUT_DIR/$OUTPUT_STATIC_FILENAME'..."
rsync -r sanshin/static "$OUTPUT_DIR/$OUTPUT_STATIC_FILENAME"
