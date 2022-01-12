# Baikal

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/ckulka/baikal) [![docker build](https://github.com/ckulka/baikal-docker/actions/workflows/docker-build.yml/badge.svg)](https://github.com/ckulka/baikal-docker/actions/workflows/docker-build.yml) ![Docker Pulls](https://img.shields.io/docker/pulls/ckulka/baikal) ![Docker Architectures](https://img.shields.io/badge/arch-amd64%20%7C%20arm32v7%20%7C%20arm64v8-informational)

This dockerfile provides a ready-to-go [Baikal server](http://sabre.io/baikal/).

For more details, see [ckulka/baikal-docker (GitHub)](https://github.com/ckulka/baikal-docker).

## Supported tags and respective Dockerfile links

I follow the same version naming scheme as [Baikal](http://sabre.io/baikal/) themselves.

The following tags support multiple architectures, e.g. `amd64`, `arm32v7` and `arm64v8`.

- [`0.9.1`, `0.9.1-apache`, `apache`, `latest`](https://github.com/ckulka/baikal-docker/blob/0.9.0/apache.dockerfile)
- [`0.9.1-nginx`, `nginx`](https://github.com/ckulka/baikal-docker/blob/0.9.0/nginx.dockerfile)
- [`0.9.0`, `0.9.0-apache`](https://github.com/ckulka/baikal-docker/blob/0.9.0/apache.dockerfile)
- [`0.9.0-nginx`](https://github.com/ckulka/baikal-docker/blob/0.9.0/nginx.dockerfile)
- [`0.8.0`, `0.8.0-apache`](https://github.com/ckulka/baikal-docker/blob/0.8.0/apache.dockerfile)
- [`0.8.0-nginx`,](https://github.com/ckulka/baikal-docker/blob/0.8.0/nginx.dockerfile)

For earlier versions all the way back to version 0.2.7, please search in the [tags](https://hub.docker.com/r/ckulka/baikal/tags) tab. Version 0.4.5 and older are only available for `amd64`.

## Quick reference

- **Where to file issues**:
  [https://github.com/ckulka/baikal-docker/issues](https://github.com/ckulka/baikal-docker/issues)
- **Supported architectures** ([more info](https://github.com/docker-library/official-images#architectures-other-than-amd64)):
  `amd64`, `arm32v7`, `arm64v8`
- **Image updates**:
  [PRs for ckulka/baikal-docker](https://github.com/ckulka/baikal-docker/pulls)
- **Source of this description**:
  [https://github.com/ckulka/baikal-docker](https://github.com/ckulka/baikal-docker)

## What is Baikal?

From [sabre.io/baikal](http://sabre.io/baikal/):

> Baikal is a Cal and CardDAV server, based on sabre/dav, that includes an administrative interface for easy management.
>
> For more information, read the main website at baikal-server.com.
>
> Baikal is developed by Net Gusto and fruux.

## How to use this image

The following command will start Baikal:

```bash
docker run --rm -it -p 80:80 ckulka/baikal:nginx
```

Alternatively, use the provided [examples/docker-compose.yaml](https://github.com/ckulka/baikal-docker/blob/master/examples/docker-compose.yaml) from the Git repository:

```bash
docker-compose up
```

You can now open [http://localhost](http://localhost) or [http://host-ip](http://host-ip) in your browser and use Baikal.

### Persistent Data

The image exposes the `/var/www/baikal/Specific` and `/var/www/baikal/config` folders, which contain the persistent data. These folders should be part of a regular backup.

If you want to use local folders instead of Docker volumes, see [examples/docker-compose.localvolumes.yaml](https://github.com/ckulka/baikal-docker/blob/master/examples/docker-compose.localvolumes.yaml) to avoid file permission issues.

### Further Guides

You can find more installation and configuration guides here:

- [SSL Certificate Guide](docs/ssl-certificates-guide.md)
- [systemd Guide](docs/systemd-guide.md)
- [Unraid Installation Guide](docs/unraid-installation-guide.md)

## Image Variants

The `ckulka/baikal` images come in several flavors, each designed for a specific use case.

### `ckulka/baikal:<version>`

This is the defacto image, as follows the official guidelines the closest using Apache httpd.

With that being said, it's worth checking out the `nginx` variant as it requires fewer resources, e.g. memory, and is a lot smaller in size.

If you are unsure about what your needs are, you probably want to use this one though.

### `ckulka/baikal:apache`

This image relies on Apache httpd and uses the [official PHP image](https://hub.docker.com/_/php/) that's packaged with the Apache web server.

It also ships with HTTPS support and self-signed certificates, which can be replaced by user-provided certificates - for more details, see the _SSL Certificates: Static Certificates_ section.

This image uses environment variables to set Apache's `ServerName` and `ServerAlias` directives to avoid Apache httpd's warnings in the logs.

The `BAIKAL_SERVERNAME` environment variable is used to set the global `ServerName` directive, e.g. `dav.example.io`. For more details, see [Apache Core Features: ServerName Directive](https://httpd.apache.org/docs/2.4/mod/core.html#servername).

The `BAIKAL_SERVERALIAS` environment variable is used to set the `ServerAlias` directive of the `VirtualHost`s, e.g. `dav.example.org dav.example.com`. For more details, see [Apache Core Features: ServerAlias Directive](https://httpd.apache.org/docs/2.4/mod/core.html#serveralias).

### `ckulka/baikal:experimental`

This image builds the `master` branch from the source repository [ckulka/baikal-docker](https://github.com/ckulka/baikal-docker). Use at your own risk.

### `ckulka/baikal:nginx`

This image relies on [nginx](https://www.nginx.com/) and uses the [official nginx image](https://hub.docker.com/_/nginx/).

Compared to the Apache variant, it is significantly smaller (less than half the size) and produces no warning messages out-of-the-box.
