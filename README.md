# PHP-prod

Use this image instead of the normal php-7.4-fpm-alpine.

It's the same except with a custom configuration more suitable for production use.

The image is rebuilt automatically whenever a new version of the original `php` image is pushed.

# Usage

## Simple PHP app with no specific extensions required

Replace `php:7.4-fpm-alpine` in your `docker-compose.yml` file with `deltablot/php-prod:7.4`.

## PHP app requiring an extension

Use `deltablot/php-prod` as base image and `docker-php-ext-install` to install the required extensions.

Example with `mysqli` is present in this repository: [Dockerfile.mysql](Dockerfile.mysqli).

## Running your code

You should have a running nginx serving your files already.

In the nginx config file:

~~~conf
location ~ \.php$ {
    fastcgi_pass php:9000;
    fastcgi_index index.php;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME /var/www/html/your-code$fastcgi_script_name;
}
~~~

Adjust the path to where your code exists (and it will depend on how you mount the volumes of course).

Example `docker-compose.yml` with nginx in a container. The websites are mounted in `/sites` in the nginx container, and the local `/sites` folder contain folders of the websites source files.

~~~yml
# NGINX
nginx:
  image: nginx:1.17-alpine
  container_name: nginx
  restart: always
  read_only: true
  depends_on:
    - php
  expose:
    - '80'
  volumes:
    - ./nginx/conf:/etc/nginx:ro
    - ./nginx/sites:/sites:ro
    - ./nginx/logs:/var/log/nginx
    - ./nginx/cache:/var/cache/nginx
    - ./nginx/pid:/var/run
  networks:
    - your-net

# PHP
php:
  image: deltablot/php-prod:7.4
  build:
    context: ./php-prod
    dockerfile: Dockerfile.mysqli
  expose:
    - '9000'
  # if hosting several sites, add them as volume here
  volumes:
    - ./nginx/sites/your-site:/var/www/html/your-site
  networks:
    - your-net
~~~

# What is changed

## Secure sessions

Sessions are moved to a dedicated directory with strict permissions.

Use strict mode and longer id length.

## Secure cookies

Force httponly and secure flag for cookies.

## Miscellaneous

* Don't expose PHP version
* Make sure only PHP files are processed
* Disallow url_fopen

# Source

Based on https://dev.to/elabftw/10-steps-for-securing-a-php-app-5fnp.

# Build from source

~~~bash
git clone https://github.com/deltablot/php-prod
cd php-prod
docker build -t deltablot/php-prod .
~~~

# License

MIT. See [LICENSE](./LICENSE) file.
