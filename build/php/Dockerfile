FROM php:7.2-fpm

ARG APP_ROOT="/srv/cacheWarmer"

ENV PHP_PORT 9000
ENV PHP_PM dynamic
ENV PHP_PM_MAX_CHILDREN 10
ENV PHP_PM_START_SERVERS 1
ENV PHP_PM_MIN_SPARE_SERVERS 1
ENV PHP_PM_MAX_SPARE_SERVERS 6

RUN \
    useradd -s /bin/bash -d ${APP_ROOT} cache \
    && chown -R cache:cache /srv \
    && echo "cache:warmer" | chpasswd

RUN \
    apt-get update \
    && apt-get install -y supervisor openssh-server git

RUN \
    docker-php-ext-install \
        pdo \
        pdo_mysql

COPY container /

RUN \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN \
    mkdir -p /var/run/sshd \
    mkdir -p /var/log/supervisor

EXPOSE 22

CMD ["/usr/bin/supervisord"]

WORKDIR ${APP_ROOT}
