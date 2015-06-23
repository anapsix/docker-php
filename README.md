## anapsix/php

Tiny container image with basic PHP 5.6 installation and Composer, based on [AlpineLinux](http://alpinelinux.org).  
If you need to run PHP scripts inside containers, but don't want the bulk of Ubuntu..


## Usage

1. make sure to have required dependencies in composer.json
2. run your php scripts as:

        docker run -it --rm -v $(pwd):/app anapsix/php --upgrade ./script_name.php

    - make your own image based on this one like so (see ./example):

            FROM anapsix/php
            CMD ["./myscript.php"]


build it:
```
docker build -t myapp .
```
and start it thus:
```
docker run -it --rm myapp
```

------------------------------------
You could (re)build this image with:
```
docker build --no-cache -t anapsix/php https://github.com/anapsix/docker-php.git
```


