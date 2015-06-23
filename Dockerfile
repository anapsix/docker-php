# anapsix/php
FROM alpine
MAINTAINER Anastas Dancha <anapsix@random.io>
RUN apk update && apk add php-cli php-cli php-pgsql php-openssl php-json php-phar php-curl git curl
RUN [ -e /usr/local/bin/composer.phar ] || \
    curl -sS https://getcomposer.org/installer | php -- --install-dir /usr/local/bin && \
    [ -e /usr/local/bin/composer.phar ] && \
    ln -s /usr/local/bin/composer.phar /usr/local/bin/composer
ADD ./docker-entrypoint.sh /entrypoint.sh

ONBUILD ADD . /app
ONBUILD RUN cd /app && composer update && composer install

WORKDIR /app
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/sh"]


## build the images as:
# docker build -t anapsix/php .

## run your php scripts as:
# docker run -it --rm -v $(pwd):/app anapsix/php ./script_name.php
#
## or make another image based on this one like so (see ./example):
# FROM anapsix/php
# CMD ["./myscript.php"]
## build it:
# docker build -t test .
## and start it thus:
# docker run -it --rm test
