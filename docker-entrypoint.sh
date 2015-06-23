#!/bin/sh
set -e

if [ "$1" == "--upgrade" ]; then
  shift 1
  echo "Resolving dependencies.." >&2
	composer.phar update >&2
  echo "Installing dependencies.." >&2
  composer.phar install >&2
fi

exec "$@"

echo fin.
