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

Replace `php-7.4-fpm-alpine` in your `docker-compose.yml` file with `deltablot/php-prod`.

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

# License

MIT. See [LICENSE](./LICENSE) file.
