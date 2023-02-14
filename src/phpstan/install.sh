#!/usr/bin/env sh

set -e

PHPSTAN_VERSION="${VERSION:-"latest"}"
PHPSTAN_INSTALL_DIR="/usr/local/bin"
PHPSTAN_URL="https://github.com/phpstan/phpstan/releases/latest/download/phpstan.phar"

if [ "$(id -u)" -ne 0 ]; then
    echo -e '(!) Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Bring in ID, ID_LIKE, VERSION_ID, VERSION_CODENAME
. /etc/os-release
# Get an adjusted ID independent of distro variants
if [ "${ID}" = "debian" ] || [ "${ID_LIKE}" = "debian" ]; then
    ADJUSTED_ID="debian"
elif [ "${ID}" = "alpine" ]; then
    ADJUSTED_ID="alpine"
else
    echo "(!) Linux distro ${ID} not supported."
    exit 1
fi

# Install packages for appropriate OS
case "${ADJUSTED_ID}" in
    "debian")
        apt-get update -y
        apt-get -y --force-yes install --no-install-recommends curl ca-certificates

        apt-get -y clean
        rm -rf /var/lib/apt/lists/*
        ;;
    "alpine")
        apk update
        apk add --no-cache curl ca-certificates
        ;;
esac

if [ "${PHPSTAN_VERSION}" != "latest" ]; then
    if [ "${PHPSTAN_VERSION}" != "${PHPSTAN_VERSION#v}" ]; then
        PHPSTAN_VERSION="${PHPSTAN_VERSION#v}"
    fi

    PHPSTAN_URL="https://github.com/phpstan/phpstan/releases/download/$PHPSTAN_VERSION/phpstan.phar"
fi

curl -o "$PHPSTAN_INSTALL_DIR/phpstan" -sfL $PHPSTAN_URL
chmod +x "$PHPSTAN_INSTALL_DIR/phpstan"
