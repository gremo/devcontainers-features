#!/usr/bin/env sh

set -e

COMPOSER_VERSION="${VERSION:-"latest"}"
COMPOSER_INSTALL_DIR="/usr/local/bin"

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

if [ "${COMPOSER_VERSION}" != "${COMPOSER_VERSION#v}" ]; then
    COMPOSER_VERSION="${COMPOSER_VERSION#v}"
fi

COMPOSER_PHAR_URL="https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar"

case "${COMPOSER_VERSION}" in
  "latest")
    COMPOSER_PHAR_URL="https://getcomposer.org/download/latest-stable/composer.phar"
  ;;
  "latest-1")
    COMPOSER_PHAR_URL="https://getcomposer.org/download/latest-1.x/composer.phar"
  ;;
  "latest-2")
    COMPOSER_PHAR_URL="https://getcomposer.org/download/latest-2.x/composer.phar"
  ;;
esac

curl -o "$COMPOSER_INSTALL_DIR/composer" -sfL $COMPOSER_PHAR_URL
chmod +x "$COMPOSER_INSTALL_DIR/composer"
