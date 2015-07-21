#!/bin/sh
set -e

[ -x /install_deps.sh ] && /install_deps.sh

if [ "$1" == "--upgrade" ] || [ "$1" == "--install" ]; then
  shift 1
  echo "Resolving dependencies.." >&2
	composer.phar update >&2
  echo "Installing dependencies.." >&2
  composer.phar install >&2
fi

exec "$@"

echo fin.
