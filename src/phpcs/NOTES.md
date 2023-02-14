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
