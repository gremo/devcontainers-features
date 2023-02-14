## Notes

The binary is `phpunit` (installed in `/usr/local/bin`). In order to run it, `php` executable must be in the `PATH`. Source code is installed in `/usr/local/lib/phpunit`.

## IDE extension

Suggested extension for this feature is [PHPUnit](https://marketplace.visualstudio.com/items?itemName=emallin.phpunit). Configure it with at least:

```json
{
    "phpunit.phpunit": "/usr/local/bin/phpunit"
}
```

If you use [PHP Intelephense](https://marketplace.visualstudio.com/items?itemName=bmewburn.vscode-intelephense-client) extension, remember to add the lib path to `environment.includePaths`:

```json
{
    "intelephense.environment.includePaths": [
        "/usr/local/lib/phpunit/src"
    ]
}
```

## OS Support

This feature should work on Debian/Ubuntu and Alpine Linux.
