# PHP-prod

Use this image instead of the normal php-7.4-fpm-alpine.

It's the same except with a custom configuration more suitable for production use.

# Build

~~~bash
git clone https://github.com/deltablot/php-prod
cd php-prod
docker build -t deltablot/php-prod .
~~~

# Usage

Replace `php-7.4-fpm-alpine` from your docker-compose.yml file with `deltablot/php-prod`.
