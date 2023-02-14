
# php-extension-installer (php-extension-installer)

Installs mlocati/php-extension-installer

## Example Usage

```json
"features": {
    "ghcr.io/gremo/devcontainers-features/php-extension-installer:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | The version to install ("latest" or exact version) | string | latest |
| extensions | List of PHP extensions to install | string | - |

## Notes

The binary is `install-php-extensions` (installed in `/usr/local/bin`). Despite the OS support of this feature, the tool works only with [official PHP docker images](https://hub.docker.com/_/php).

## OS Support

This feature should work on Debian/Ubuntu and Alpine Linux.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/gremo/devcontainers-features/blob/main/src/php-extension-installer/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
