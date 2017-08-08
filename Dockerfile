FROM python:3

ENV PYTHONUNBUFFERED 1

# ------------------------------------------
# install necessary packages via apt-get:
# ------------------------------------------
# RUN apt-get update && \
# apt-get install -y --no-install-recommends

# this is supposed to save memory:
RUN rm -rf /var/lib/apt/lists/*

# location of the source outside the container:
ENV SERVER_SRC src

# Directory in container for all project files
ENV INSTALL_DIR /sanshin/server
ENV MEDIA_DIR /sanshin/media

# cd into the servers home:
WORKDIR "$INSTALL_DIR"

COPY requirements.txt "$INSTALL_DIR/"

RUN pip install -r requirements.txt

COPY $SERVER_SRC $INSTALL_DIR

# ENV DJANGO_SETTINGS_MODULE "website.dev_settings"
