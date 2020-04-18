#!/usr/bin/env bash

set -e

readonly arguments=$(nginx -V 2>&1|grep '^configure arguments:'|cut -d ' ' -f 3-) || {
  echo "Failed to get configure arguments for current nginx." >&2
  exit 1
}

# Inline arguments as shell arguments.
bash -c "./configure ${arguments} --with-debug --add-dynamic-module=../nginx-rtmp-module"
