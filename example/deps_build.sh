#!/bin/sh

if [ "$1" == "--cleanup" ]; then
  echo "Optional cleanup step.." >&2
  ls -la /app >&2
fi
