#!/usr/bin/env bash

set -eu
set -o pipefail

LFS_LISTEN="tcp://:9999"
LFS_HOST="127.0.0.1:9999"
LFS_CONTENTPATH="content"
LFS_ADMINUSER="coglinks"
LFS_ADMINPASS="EoF7zovfZrQf7UtbVa8ARL"
LFS_CERT="mine.crt"
LFS_KEY="mine.key"
LFS_SCHEME="https"

export LFS_LISTEN LFS_HOST LFS_CONTENTPATH LFS_ADMINUSER LFS_ADMINPASS LFS_CERT LFS_KEY LFS_SCHEME

./lfs-test-server
