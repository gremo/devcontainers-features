
# Deployer (deployer)

Installs Deployer

## Example Usage

```json
"features": {
    "ghcr.io/gremo/devcontainers-features/deployer:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | The version to install ("latest" or exact version) | string | latest |

## Notes

The binary is `dep` (installed in `/usr/local/bin`). In order to run it, `php` executable must be in the `PATH`. Source code is installed in `/usr/local/lib/deployer`.

## IDE extension

If you use [PHP Intelephense](https://marketplace.visualstudio.com/items?itemName=bmewburn.vscode-intelephense-client) extension, remember to add the source code path to `environment.includePaths`:

> **Note**: this is only relevant using recipes written in PHP (and not YAML).

```json
{
    "intelephense.environment.includePaths": [
        "/usr/local/lib/deployer/src"
    ]
}
```

## OS Support

This feature should work on Debian/Ubuntu and Alpine Linux.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/gremo/devcontainers-features/blob/main/src/deployer/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
