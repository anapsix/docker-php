# anapsix/php
FROM alpine
MAINTAINER Anastas Dancha <anapsix@random.io>
RUN apk upgrade --update && apk add php-cli php-openssl php-json php-phar php-curl git curl
RUN [ -e /usr/local/bin/composer.phar ] || \
    curl -sS https://getcomposer.org/installer | php -- --install-dir /usr/local/bin && \
    [ -e /usr/local/bin/composer.phar ] && \
    ln -s /usr/local/bin/composer.phar /usr/local/bin/composer
ADD ./docker-entrypoint.sh /entrypoint.sh

ONBUILD ADD . /app
ONBUILD RUN if [ -e ./deps.apk ]; then apk update && grep -v "^#\|^$" ./deps.apk | xargs apk add; else echo "no ./deps.apk file found, skipping dependecy installation"; fi
ONBUILD RUN if [ -x ./deps.sh ]; then ./deps.sh; else echo "no ./deps.sh file found, skipping script execution" >&2; fi
ONBUILD RUN cd /app && composer update && composer install

VOLUME /app
WORKDIR /app
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/sh"]

### NOTES
## run your php scripts as:
# docker run -it --rm -v $(pwd):/app anapsix/php ./script_name.php
#
## or make another image based on this one like so (see ./example):
# FROM anapsix/php
# CMD ["./example.php"]
#
## to install additional packages,
## place one package name per line into ./deps.apk
## for list of available packages see http://pkgs.alpinelinux.org/packages
#
## for custom actions, create deps.sh executable script
#
## build it like so:
# docker build -t test .
## and run it thus:
# docker run -it --rm test
