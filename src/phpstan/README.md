
# PHPStan (phpstan)

Installs PHPStan

## Example Usage

```json
"features": {
    "ghcr.io/gremo/devcontainers-features/phpstan:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | The version to install ("latest" or exact version) | string | latest |

## Notes

The binary is `phpstan` (installed in `/usr/local/bin`). In order to run it, `php` executable must be in the `PATH`.

## IDE extension

Suggested extension for this feature is [PHPStan](https://marketplace.visualstudio.com/items?itemName=swordev.phpstan). Configure it with at least:

```json
{
    "phpstan.path": "/usr/local/bin/phpstan"
}
```

## OS Support

This feature should work on Debian/Ubuntu and Alpine Linux.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/gremo/devcontainers-features/blob/main/src/phpstan/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
