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
