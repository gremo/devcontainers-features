
# Symfony PHP configuration (symfony-php-config)

Configures PHP for Symfony framework

## Example Usage

```json
"features": {
    "ghcr.io/gremo/devcontainers-features/symfony-php-config:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| memoryLimit | memory_limit value | string | 256M |
| realpathCacheSize | realpath_cache_size value | string | 4096K |
| realpathCacheTtl | realpath_cache_ttl value | string | 600 |
| opcacheMaxAcceleratedFiles | opcache.max_accelerated_files value | string | 20000 |
| opcacheMemoryConsumption | opcache.memory_consumption value | string | 256 |
| xdebugClientHost | xdebug.client_host value | string | host.docker.internal |

## Notes

This feature creates a `00_symfony.ini` file that holds the settings according to the [official documentation](https://symfony.com/doc/current/performance.html).

## OS Support

This feature should work on Debian/Ubuntu and Alpine Linux.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/gremo/devcontainers-features/blob/main/src/symfony-php-config/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
