# Dev Containers features
![Banner](https://user-images.githubusercontent.com/1532616/217323824-858c0f27-38c9-4156-9fb2-24f65d5bdf29.png)

<p align="center">
  A collection of reusable <b>Visual Studio Code Dev Containers features</b> related to PHP and Symfony framework.
</p>

This project is a set of reusable Visual Studio Code Dev Containers features. Quickly add a tool/cli to a development container.

*Features* are self-contained units of installation code and development container configuration. Features are designed to install atop a wide-range of base container images (this repository focuses on PHP and Symfony related ones).

> This repo follows the [dev container feature distribution specification](https://containers.dev/implementors/features-distribution).

## 📜 List of repository features

OS related:

- [system-pkgs](src/system-pkgs): installs system packages from package manager

Tools:

- [composer](src/composer): installs [Composer](https://getcomposer.org)
- [php-extension-installer](src/php-extension-installer): installs [php-extension-installer](https://github.com/mlocati/docker-php-extension-installer)
- [symfony-cli](src/symfony-cli): installs [Symfony CLI](https://symfony.com/download)
- [phpstan](src/phpstan): installs [PHPStan](https://phpstan.org)
- [phpcs](src/phpcs): installs [PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)
- [phpunit](src/phpunit): installs [PHPUnit](https://phpunit.de)
- [deployer](src/deployer): installs [Deployer](https://deployer.org)

PHP related:

- [php-config](src/php-config): customizes the PHP configuration
- [symfony-php-config](src/symfony-php-config): creates a PHP configuration suited for [Symfony](https://symfony.com) projects

## 💡 Examples

A **minimal PHP development environment** with Composer:

```json
{
  "image": "php:cli-alpine",
  "features": {
    "ghcr.io/gremo/devcontainers-features/system-pkgs": {
      "packages": "unzip"
    },
    "ghcr.io/gremo/devcontainers-features/php-config": {},
    "ghcr.io/gremo/devcontainers-features/php-extension-installer": {
      "extensions": "zip"
    },
    "ghcr.io/gremo/devcontainers-features/composer": {}
  },
  "mounts": [
    {
      "source": "${localWorkspaceFolderBasename}-vendor",
      "target": "${containerWorkspaceFolder}/vendor",
      "type": "volume"
    }
  ]
}
```

A **Symfony development environment** with Symfony CLI:

```json
{
  "image": "php:cli-alpine",
  "features": {
    "ghcr.io/gremo/devcontainers-features/system-pkgs": {
      "packages": "unzip"
    },
    "ghcr.io/gremo/devcontainers-features/php-config": {},
    "ghcr.io/gremo/devcontainers-features/symfony-php-config": {},
    "ghcr.io/gremo/devcontainers-features/php-extension-installer": {
      "extensions": "apcu intl opcache xdebug zip"
    },
    "ghcr.io/gremo/devcontainers-features/composer": {},
    "ghcr.io/gremo/devcontainers-features/symfony-cli": {}
  },
  "mounts": [
    {
      "source": "${localWorkspaceFolderBasename}-var",
      "target": "${containerWorkspaceFolder}/var",
      "type": "volume"
    },
    {
      "source": "${localWorkspaceFolderBasename}-vendor",
      "target": "${containerWorkspaceFolder}/vendor",
      "type": "volume"
    }
  ]
}
```

Rebuild and reopen the project in a remote container and run:

```shell
wget https://raw.githubusercontent.com/symfony/skeleton/6.2/composer.json
composer install
symfony server:start
```

## ❓ Tips and ideas

### Improve performances

See [Improve disk performance](https://code.visualstudio.com/remote/advancedcontainers/improve-performance) guide to use volume mounts for directories like `vendor`, `node_modules` or cache-related ones. Also take a look at the [full options reference](https://containers.dev/implementors/json_reference).

### Set the system timezone

Add the package `tzdata` and pass the `TZ` environment variable:

```json5
{
  "features": {
    // ...
    "ghcr.io/gremo/devcontainers-features/system-pkgs": {
        "packages": "tzdata"
    },
  },
  "remoteEnv": {
    "TZ": "Europe/Rome"
  },
}
```

### Further PHP customizations

Either add commands in the `postCreateCommand`:

> **Note**: you can "sync" the system timezone with PHP configuration using a custom `postCreateCommand` command, using `echo \"date.timezone = $TZ\ >> $PHP_INI_DIR/conf.d/zz_custom.ini` as value.

```json5
{
  // ...
  "postCreateCommand": {
    "php-directive1": "echo 'memory_limit = 256M' >> $PHP_INI_DIR/conf.d/zz_custom.ini"
  }
}
```

Even better, you can bind-mount a custom PHP INI file. Just create an empty file `.devcontainer/php.ini` and bind-mount it:

```json5
{
  // ...
  "mounts": [
    {
      "source": "${localWorkspaceFolder}/.devcontainer/php.ini",
      "target": "/usr/local/etc/php/conf.d/zz_custom.ini",
      "type": "bind,consistency=cached"
    }
  ]
}
```
