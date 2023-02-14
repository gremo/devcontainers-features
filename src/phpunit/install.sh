#!/usr/bin/env sh
set -e

PHPUNIT_VERSION="${VERSION:-"latest"}"
PHPUNIT_INSTALL_DIR="/usr/local/bin"
INSTALL_LIB="${INSTALLLIB:-"true"}"
INSTALL_LIB_LOCATION="/usr/local/lib/phpunit"

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
        apt-get -y --force-yes install --no-install-recommends curl ca-certificates jq

        apt-get -y clean
        rm -rf /var/lib/apt/lists/*
        ;;
    "alpine")
        apk update
        apk add --no-cache curl ca-certificates jq
        ;;
esac

if [ "${PHPUNIT_VERSION}" = "latest" ]; then
    PHPUNIT_VERSION=$(curl -sf "https://api.github.com/repos/sebastianbergmann/phpunit/tags" | jq -r '.[0].name')
    if [ -z "${PHPUNIT_VERSION}" ]; then
        echo "(!) Failed to get the latest version."
        exit 1
    fi
fi

if [ "${PHPUNIT_VERSION}" != "${PHPUNIT_VERSION#v}" ]; then
    PHPUNIT_VERSION="${PHPUNIT_VERSION#v}"
fi

PHPUNIT_PHAR_URL="https://phar.phpunit.de/phpunit-$PHPUNIT_VERSION.phar"
PHPUNIT_ARCHIVE_URL="https://github.com/sebastianbergmann/phpunit/archive/refs/tags/$PHPUNIT_VERSION.tar.gz"

curl -o "$PHPUNIT_INSTALL_DIR/phpunit" -sfL $PHPUNIT_PHAR_URL
chmod +x "$PHPUNIT_INSTALL_DIR/phpunit"

if [ "${INSTALL_LIB}" = "true" ]; then
    mkdir -p "$INSTALL_LIB_LOCATION"
    curl -sL "$PHPUNIT_ARCHIVE_URL" | tar -xz --strip-components=1 -C "$INSTALL_LIB_LOCATION"
fi
