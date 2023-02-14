#!/usr/bin/env bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "phpcs bin location" bash -c "ls /usr/local/bin/phpcs"
check "phpcbf bin location" bash -c "ls /usr/local/bin/phpcbf"

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
