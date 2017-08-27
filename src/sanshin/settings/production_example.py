# production settings


from .base import *

USE_X_FORWARDED_HOST = True

SECRET_KEY = "" # TODO

ALLOWED_HOSTS = [ "127.0.0.1", "localhost", ] # <- TODO

DEBUG=False

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': "", # TODO
        'USER': "", # TODO
        'PASSWORD': "", # TODO
        'HOST': "/home/sanshin/tmp/",
    }
}
