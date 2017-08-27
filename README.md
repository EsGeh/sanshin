# sanshin
website for the sanshin dojo Berlin

## requirements

In order to locally download the server, please install these dependencies:

- git

## installing

clone the git repository.

	$ git clone <url_to_repository>

## dependencies

In order to be able to install and run the server, please install these dependencies:

- docker
- docker-compose

## prerequisites

- install static data
- import database dump
- apply migrations

	$ ./scripts/migrate.sh

## run server

	$ ./scripts/run_server.sh

## dump all data from database

	$ ./scripts/dump.sh

## installing to uberspace

1. set the production settings
	
	create ./src/sanshin/settings/production.py:

		$ cp ./src/sanshin/settings/production_example.py ./src/sanshin/settings/production.py 
	
	now adjust the marked fields accordingly. Keep this file secret!

2. upload the project

		$ ./scripts/upload.sh

	(this will also install the necessary dependencies on the uberspace)

3. connect to uberspace: 

		$ ssh <uberspace address>
		$ cd sanshin

4. import database dump

		$ ./scripts/production/import_data.sh

## control server on uberspace

1. if necessary, load environment variables (see below)

2. run the server

		$ ./scripts/production/run.sh

3. to stop the server:

	$ ./scripts/production/rm_service.sh

## load environment variables on uberspace

	1. if necessary, recreate settings file:

			$ ./scripts/production/create_env_settings.sh

	2. load the settings

			$ source ~/.django_config
