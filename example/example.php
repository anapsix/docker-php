#!/usr/bin/env php
<?php
require_once('vendor/autoload.php');

$s = new HelloWorld\HelloWorld();
print $s -> sayHello() . "\n";
