#!/bin/sh

set -e

# If we're using Alpine, install bash before executing
. /etc/os-release
if [ "${ID}" = "alpine" ]; then
    apk add --no-cache bash
fi

exec /bin/bash "$(dirname $0)/main.sh" "$@"
exit $?
