
# PHP_CodeSniffer (phpcs)

Installs PHP_CodeSniffer

## Example Usage

```json
"features": {
    "ghcr.io/gremo/devcontainers-features/phpcs:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | The version to install ("latest" or exact version) | string | latest |

## Notes

The binaries are `phpcs` and `phpcbf` (installed in `/usr/local/bin`). In order to run it, `php` executable must be in the `PATH`.

## IDE extension

Suggested extension for this feature is [PHP Sniffer & Beautifier](https://marketplace.visualstudio.com/items?itemName=ValeryanM.vscode-phpsab). Configure it with at least:

```json
{
    "phpsab.executablePathCBF": "/usr/local/bin/phpcbf",
    "phpsab.executablePathCS": "/usr/local/bin/phpcs"
}
```

## OS Support

This feature should work on Debian/Ubuntu and Alpine Linux.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/gremo/devcontainers-features/blob/main/src/phpcs/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
