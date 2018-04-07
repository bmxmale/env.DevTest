#!/bin/bash

docker run -it \
            --rm \
            -e MYSQL_DATABASE=development \
            -e MYSQL_USER=development \
            -e MYSQL_PASSWORD=development \
            -v `pwd`/mount/mysql/data:/var/lib/mysql \
            bmxmale/docker-mysql-data-initializer:latest

git clone git@github.com:bmxmale/php-recruitment-test.git --single-branch --branch mati app/php-recruitment-test

cp conf.ini app/php-recruitment-test

cd app/php-recruitment-test
composer install -v -o

docker-compose up -d

docker exec -it CacheWarmer_PHP php console.php migrate_db
docker exec -it CacheWarmer_PHP php console.php warm 1
docker exec -it CacheWarmer_PHP php console.php warm 2
docker exec -it CacheWarmer_PHP php console.php warm 3