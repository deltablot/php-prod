FROM php:7.4-fpm-alpine

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Override with custom settings
COPY config/sessions.ini $PHP_INI_DIR/conf.d/
COPY config/misc.ini $PHP_INI_DIR/conf.d/
