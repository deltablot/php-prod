# https://github.com/deltablot/php-prod
# License: MIT
FROM php:8.1.24-fpm-alpine

# use default prod config
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# sessions
RUN mkdir /sessions && chown 82:82 /sessions && chmod 700 /sessions
COPY config/sessions.ini $PHP_INI_DIR/conf.d/

# miscellaneous
COPY config/misc.ini $PHP_INI_DIR/conf.d/
