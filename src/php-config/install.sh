#!/usr/bin/env sh

set -e

PHP_INI_DIR="${PHP_INI_DIR:-"/usr/local/etc/php"}"
PHP_INI_SOURCE="$PHP_INI_DIR/${SOURCE:-"php.ini-development"}"
PHP_INI_DEST="$PHP_INI_DIR/php.ini"

if [ "$(id -u)" -ne 0 ]; then
    echo -e '(!) Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

mkdir -p $(dirname $PHP_INI_DEST)
touch "$PHP_INI_DEST"

if [ -e "${PHP_INI_SOURCE}" ]; then
    rm -f "$PHP_INI_DEST"
    ln -s "$PHP_INI_SOURCE" "$PHP_INI_DEST"
fi
