# PacMan
Utility to configure build tools to use security gateway as package repository.
Refer to [https://safedep.io](https://safedep.io) for more details.

`pacman` aka. `Package Manager` inspired by the `pacman` is a tool for easily configuring various package managers such as Gradle, Maven etc. to use the security gateway for downloading required dependencies.

## Setup

Run `pacman` configuration wizard

```bash
./pacman.sh configure
```

### Configure Gradle

```bash
./pacman.sh setup-gradle
```

### Configure Maven

```bash
./pacman.sh setup-maven
```

> **Note:** This script overwrite `$HOME/.m2/settings.xml`

### Configuring Project

To configure package managers building a specific project, set environment

```
GATEWAY_PROJECT_ID=project-id
```

## Cleanup

Remove any configuration file added by `pacman`

```bash
./pacman clean
```

## Using Github Action

Configure gateway credentials using Github secret named

1. `GATEWAY_URL`
2. `GATEWAY_USERNAME`
3. `GATEWAY_PASSWORD`

Use the following Github action step just before invoking application build

```yaml
jobs:
  build:
    steps:
    [...]
    - name: Configure environment to use SafeDep Gateway
      uses: safedep/pacman@main
      with:
        gateway_url: ${{ secrets.GATEWAY_URL }}
        gateway_username: ${{ secrets.GATEWAY_USERNAME }}
        gateway_password: ${{ secrets.GATEWAY_PASSWORD }}
        package_manager: maven
```

> Github recommends using `commit SHA` to pin 3rd party actions instead of ref

### Supported Package Managers

- maven
- gradle
- pip

# Reference

* https://www.google.com/logos/2010/pacman10-i.html
