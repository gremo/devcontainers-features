#!/usr/bin/env sh
set -e

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

        curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
        apt-get -y --force-yes install symfony-cli

        apt-get -y clean
        rm -rf /var/lib/apt/lists/*
        ;;
    "alpine")
        apk update
        apk add --no-cache curl ca-certificates bash

        curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.alpine.sh' | bash
        apk add --no-cache symfony-cli
        ;;
esac
