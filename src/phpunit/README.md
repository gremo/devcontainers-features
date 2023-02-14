
# PHPUnit (phpunit)

Installs PHPUnit

## Example Usage

```json
"features": {
    "ghcr.io/gremo/devcontainers-features/phpunit:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | The version to install ("latest" or exact version) | string | latest |
| installLib | Whether to install source code or not | boolean | true |

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


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/gremo/devcontainers-features/blob/main/src/phpunit/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
