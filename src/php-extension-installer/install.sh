#!/usr/bin/env sh

set -e

PHPEXTINSTALLER_VERSION="${VERSION:-"latest"}"
PHPEXTINSTALLER_INSTALL_DIR="/usr/local/bin"
PHPEXTINSTALLER_URL="https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions"

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

if [ "${PHPEXTINSTALLER_VERSION}" != "latest" ]; then
    if [ "${PHPEXTINSTALLER_VERSION}" != "${PHPEXTINSTALLER_VERSION#v}" ]; then
        PHPEXTINSTALLER_VERSION="${PHPEXTINSTALLER_VERSION#v}"
    fi

    PHPEXTINSTALLER_URL="https://github.com/mlocati/docker-php-extension-installer/releases/download/$PHPEXTINSTALLER_VERSION/install-php-extensions"
fi

curl -o "$PHPEXTINSTALLER_INSTALL_DIR/install-php-extensions" -fL "$PHPEXTINSTALLER_URL"
chmod +x "$PHPEXTINSTALLER_INSTALL_DIR/install-php-extensions"

if [ -n "$EXTENSIONS" ]; then
    install-php-extensions $EXTENSIONS
fi
