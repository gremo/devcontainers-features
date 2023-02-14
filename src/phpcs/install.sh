#!/usr/bin/env sh

set -e

PHPCS_VERSION="${VERSION:-"latest"}"
PHPCS_INSTALL_DIR="/usr/local/bin"
PHPCS_DOWNLOAD_URL="https://github.com/squizlabs/PHP_CodeSniffer/releases/latest/download/phpcs.phar"
PHPCBF_DOWNLOAD_URL="https://github.com/squizlabs/PHP_CodeSniffer/releases/latest/download/phpcbf.phar"

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

if [[ "${PHPCS_VERSION}" != "latest" ]]; then
    if [ "${PHPCS_VERSION}" != "${PHPCS_VERSION#v}" ]; then
        PHPCS_VERSION="${PHPCS_VERSION#v}"
    fi

    PHPCS_DOWNLOAD_URL="https://github.com/squizlabs/PHP_CodeSniffer/releases/download/$PHPCS_VERSION/phpcs.phar"
    PHPCBF_DOWNLOAD_URL="https://github.com/squizlabs/PHP_CodeSniffer/releases/download/$PHPCS_VERSION/phpcbf.phar"
fi

curl -o "$PHPCS_INSTALL_DIR/phpcs" -fLs $PHPCS_DOWNLOAD_URL
chmod +x "$PHPCS_INSTALL_DIR/phpcs"

curl -o "$PHPCS_INSTALL_DIR/phpcbf" -fLs $PHPCBF_DOWNLOAD_URL
chmod +x "$PHPCS_INSTALL_DIR/phpcbf"
