## anapsix/php

Tiny (38MB) container image with basic PHP 5.6 installation and Composer, based on [AlpineLinux](http://alpinelinux.org).  
If you need to run PHP scripts inside containers, but don't want the bulk of Ubuntu..

[![](https://badge.imagelayers.io/anapsix/php:latest.svg)](https://imagelayers.io/?images=anapsix/php:latest 'Get your own badge on imagelayers.io')

## Usage

### Running anapsix/php
1. make sure to have required dependencies in composer.json
2. run your php scripts as:

        docker run -it --rm -v $(pwd):/app anapsix/php --upgrade ./script_name.php

    - make your own image based on this one like so (see ./example):

            FROM anapsix/php
            CMD ["./myscript.php"]


### Building FROM anapsix/php
To install additional dependencies for your script/application, you can place package names (one per line, comments and empty lines are ignored) into `./deps.apk`.
It will be checked for during the build and packages will be installed via `apk`.  
For list of available packages see http://pkgs.alpinelinux.org/packages.  
For additional convenience, if `./deps.sh` exists and __is executable__, it will be run after `./deps.apk` is processed. This should allow you to install additional libraries not available in AlpineLinux APK repository  or perform any custom action (i.e. create users, clone a repo, install packages from pecl/pear, etc).


Build it so:

    docker build -t myapp .

and start it thus:

   docker run -it --rm myapp


------------------------------------
You could (re)build this image locally with:
```
docker build --no-cache -t anapsix/php https://github.com/anapsix/docker-php.git
```

