## anapsix/php

42MB container image with basic PHP 5.6 installation and Composer,
based on [AlpineLinux](http://alpinelinux.org).  
If you need to run PHP scripts inside containers,
but don't want the bulk of Ubuntu..

[![Build Status](https://travis-ci.org/anapsix/docker-php.svg?branch=master)](https://travis-ci.org/anapsix/docker-php)

[![](https://badge.imagelayers.io/anapsix/php:latest.svg)](https://imagelayers.io/?images=anapsix/php:latest)

## Usage

### Running anapsix/php
1. make sure to have required dependencies in composer.json
2. run your php scripts as:

        docker run -it --rm -v $(pwd):/app anapsix/php --upgrade ./script_name.php


### Building FROM anapsix/php
Make your own image based on this one like so
(see [./example][https://github.com/anapsix/docker-php/tree/master/example]):

    FROM anapsix/php
    CMD ["./myscript.php"]

To install _additional dependencies_ for your script/application, you can
place package names (one per line, comments and empty lines are ignored) into
`./deps.apk`. It will be checked for during the build and packages will be
installed via `apk`.  
To install _build-time only_ dependencies (system libraries, etc),
placepackage names into `./deps_build.apk`. They will be removed after
`compose install`.


> For list of available packages see [http://pkgs.alpinelinux.org/packages](http://pkgs.alpinelinux.org/packages).

For additional convenience, if `./deps.sh` exists and __is executable__, it
will be run after `./deps.apk` is processed. This should allow you to install
additional libraries not available in AlpineLinux APK repository or perform
any custom action (i.e. create users, clone a repo, install packages from
pecl/pear, etc).  
Similarly to `./deps_build.apk`, `./deps_build.sh` can be used for custom
build-time pre-`composer install` steps. It is expected to be executable,
if present. After `compose install` it will be executed again with `--cleanup`
argument, which should allow for custom cleanup step.


Build it so:

    docker build -t myapp .

and start it thus:

    docker run -it --rm myapp


------------------------------------
You could (re)build this image locally with:

    docker build --no-cache -t anapsix/php https://github.com/anapsix/docker-php.git


