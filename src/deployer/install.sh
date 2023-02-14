#!/usr/bin/env sh

set -e

DEPLOYER_VERSION="${VERSION:-"latest"}"
DEPLOYER_INSTALL_DIR="/usr/local/bin"
INSTALL_LIB="${INSTALLLIB:-"true"}"
INSTALL_LIB_LOCATION="/usr/local/lib/deployer"

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

if [ "${DEPLOYER_VERSION}" = "latest" ]; then
    DEPLOYER_VERSION=$(curl -sf "https://api.github.com/repos/deployphp/deployer/releases/latest" | grep "tag_name" | awk '{print substr($2, 3, length($2)-4)}')
    if [ -z "${DEPLOYER_VERSION}" ]; then
        echo "(!) Failed to get the latest version."
        exit 1
    fi
fi

if [ "${DEPLOYER_VERSION}" != "${DEPLOYER_VERSION#v}" ]; then
    DEPLOYER_VERSION="${DEPLOYER_VERSION#v}"
fi

DEPLOYER_PHAR_URL="https://github.com/deployphp/deployer/releases/download/v$DEPLOYER_VERSION/deployer.phar"
DEPLOYER_ARCHIVE_URL="https://github.com/deployphp/deployer/archive/refs/tags/v$DEPLOYER_VERSION.tar.gz"

case "${DEPLOYER_VERSION}" in
  "6"* | "5"* | "4".* | "3".* | "2".* | "1".*)
    DEPLOYER_PHAR_URL="https://deployer.org/releases/v$DEPLOYER_VERSION/deployer.phar"
  ;;
esac

curl -o "$DEPLOYER_INSTALL_DIR/dep" -sfL $DEPLOYER_PHAR_URL
chmod +x "$DEPLOYER_INSTALL_DIR/dep"

if [ "${INSTALL_LIB}" = "true" ]; then
    mkdir -p "$INSTALL_LIB_LOCATION"
    curl -sL "$DEPLOYER_ARCHIVE_URL" | tar -xz --strip-components=1 -C "$INSTALL_LIB_LOCATION"
fi
