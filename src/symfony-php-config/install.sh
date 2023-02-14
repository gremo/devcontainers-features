#!/usr/bin/env sh

set -e

PHP_INI_DIR="${PHP_INI_DIR:-"/usr/local/etc/php"}"

INI_CONF_DIR="${PHP_INI_DIR}/conf.d"
INI_DEST_OVERRIDES_FILE="${INI_CONF_DIR}/00_symfony.ini"

INI_MEMORY_LIMIT="${MEMORYLIMIT:-"256M"}"
INI_REALPATH_CACHE_SIZE="${REALPATHCACHESIZE:-"4096K"}"
INI_REALPATH_CACHE_TTL="${REALPATHCACHETTL:-"600"}"
INI_OPCACHE_MEMORY_CONSUMPTION="${OPCACHEMEMORYCONSUMPTION:-"256"}"
INI_OPCACHE_MAX_ACCELERATED_FILES="${OPCACHE_MAX_ACCELERATED_FILES:-"20000"}"
INI_XDEBUG_CLIENT_HOST="${XDEBUGCLIENTHOST:-"host.docker.internal"}"

if [ "$(id -u)" -ne 0 ]; then
    echo -e '(!) Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

mkdir -p "$INI_CONF_DIR"

echo "memory_limit = ${INI_MEMORY_LIMIT}" >> "$INI_DEST_OVERRIDES_FILE"
echo "realpath_cache_size = ${INI_REALPATH_CACHE_SIZE}" >> "$INI_DEST_OVERRIDES_FILE"
echo "realpath_cache_ttl = ${INI_REALPATH_CACHE_TTL}" >> "$INI_DEST_OVERRIDES_FILE"
echo "opcache.memory_consumption = ${INI_OPCACHE_MEMORY_CONSUMPTION}" >> "$INI_DEST_OVERRIDES_FILE"
echo "opcache.max_accelerated_files = ${INI_OPCACHE_MAX_ACCELERATED_FILES}" >> "$INI_DEST_OVERRIDES_FILE"
echo "apc.enable_cli = 1" >> "$INI_DEST_OVERRIDES_FILE"
echo "xdebug.client_host = '$INI_XDEBUG_CLIENT_HOST'" >> "$INI_DEST_OVERRIDES_FILE"
