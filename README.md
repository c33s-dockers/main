# Docker Images

Autobuild repo for multi-purpose docker images ([Debian][debian], [Php][php] and Building & packaging). 

Initially created for use in the [gitlab] ci to test and check [symfony] applications. prepared for the usage with 
[LiipImagineBundle Post-Processors](https://symfony.com/doc/current/bundles/LiipImagineBundle/post-processors.html) and
then extended for building (make) and packaging (deb, rpm).


![github license](https://img.shields.io/github/license/c33s-dockers/main)
![maintanance status](https://img.shields.io/maintenance/yes/2021)

---

## Images

### Debian Images

![](https://img.shields.io/docker/cloud/build/c33s/debian)
![](https://img.shields.io/docker/cloud/automated/c33s/debian?label=debian%20docker%20build)
![](https://img.shields.io/docker/pulls/c33s/debian)

Plain [debian] image, mostly used as base image for the other images with only less packages included. 

debian build is only failing for wheezy 7 but [shield.io] does not support 
[build status for tags](https://github.com/badges/shields/issues/935) as docker does not support it.

| tag                  | debian       | offical support  | size                                                                      |
| ----------           | -------      | --------         | ---                                                                       |
| 11, bullseye, latest | bullseye 11  | LTS TBA          | ![](https://img.shields.io/docker/image-size/c33s/debian/bullseye?label=) |
| 10, buster           | buster 10    | LTS 2024         | ![](https://img.shields.io/docker/image-size/c33s/debian/buster?label=)   |
| 9, stretch           | stretch 9    | LTS June 2022    | ![](https://img.shields.io/docker/image-size/c33s/debian/stretch?label=)  |
| 8, jessie            | jessie 8     | LTS 30 June 2020 | ![](https://img.shields.io/docker/image-size/c33s/debian/jessie?label=)   |
| 7, wheezy            | wheezy 7 (*) | LTS 31 May 2018  | ![](https://img.shields.io/docker/image-size/c33s/debian/wheezy?label=)   |

(*) build is broken, will likely be deprecated and removed.

[Debian Version History](https://en.wikipedia.org/wiki/Debian_version_history#Release_table)

### Php Images

![](https://img.shields.io/docker/cloud/build/c33s/php)
![](https://img.shields.io/docker/cloud/automated/c33s/php?label=php%20docker%20build)
![](https://img.shields.io/docker/pulls/c33s/php)

Php images for usage with symfony. Please support [Ondřej Surý](https://deb.sury.org/#donate) for his effort on 
maintaining the php [debian] packages.

| tag | debian    |  php repo | size |
| --- | -------   | --------- | --- |
| 8.0 | buster 10 | [sury]    | ![](https://img.shields.io/docker/image-size/c33s/php/8.0?label=) |
| 7.4 | buster 10 | [sury]    | ![](https://img.shields.io/docker/image-size/c33s/php/7.4?label=) |
| 7.3 | buster 10 | [sury]    | ![](https://img.shields.io/docker/image-size/c33s/php/7.3?label=) |
| 7.2 | stretch 9 | [sury]    | ![](https://img.shields.io/docker/image-size/c33s/php/7.2?label=) |
| 7.1 | stretch 9 | [sury]    | ![](https://img.shields.io/docker/image-size/c33s/php/7.1?label=) |
| 7.0 | stretch 9 | [sury]    | ![](https://img.shields.io/docker/image-size/c33s/php/7.0?label=) |
| 5.6 | jessie  8 | [dotdeb]  | ![](https://img.shields.io/docker/image-size/c33s/php/5.6?label=) |
 
contain overview:

- [Composer - A Dependency Manager for PHP](https://getcomposer.org/)
- [Jpegoptim - utility to optimize jpeg files](https://www.kokkonen.net/tjko/projects.html)
- [MariaDb - Database management system, relational, open source, community developed fork of MySQL](https://mariadb.org/)
- [Mozilla JPEG Encoder Project - Improved JPEG encoder. ](https://github.com/mozilla/mozjpeg)
- [Node.js - open-source, cross-platform, back-end JavaScript runtime environment](https://nodejs.org/)
- [OptiPNG - a lossless PNG optimizer that recompresses image files to a smaller size](http://optipng.sourceforge.net/)
- [pngquant - a command-line utility and a library for lossy compression of PNG images](https://pngquant.org/)
- [PostgreSQL - Free and open-source relational database management system](https://www.postgresql.org/)
- [Robo - Modern Task Runner for PHP](https://robo.li/)
- [Yarn - a package manager that doubles down as project manager](https://yarnpkg.com/)

### Build Images

![](https://img.shields.io/docker/cloud/build/c33s/build)
![](https://img.shields.io/docker/cloud/automated/c33s/build?label=build%20docker%20build)
![](https://img.shields.io/docker/pulls/c33s/build)

For building code and package them.

| tag          | debian      | size                                                                               |
| -------      | ---------   | ---                                                                                |
| 11, bullseye | bullseye 11 | ![](https://img.shields.io/docker/image-size/c33s/build/bullseye?label=bullseye%2011)  |
| 10, buster   | buster 10   | ![](https://img.shields.io/docker/image-size/c33s/build/buster?label=buster%2010)  |
| 9, stretch   | stretch 9   | ![](https://img.shields.io/docker/image-size/c33s/build/stretch?label=stretch%209) |

contains:

- several linux build tools
- [fpm - Build packages for multiple platforms (deb, rpm, etc)](https://github.com/jordansissel/fpm)

## Links

- [Docker Hub](https://hub.docker.com/r/c33s/)
- [Docker Hub Debian Builds](https://hub.docker.com/repository/docker/c33s/debian/builds)
- [Docker Hub Php Builds](https://hub.docker.com/repository/docker/c33s/php/builds)
- [Github Mirror Repo for Auto-Build](https://github.com/c33s-dockers/main)
- [Main Repo](https://gitlab.com/c33s.infrastructure/docker/)
- [Windows Node Version Manager](https://github.com/coreybutler/nvm-windows)
- [Linux/OSX Node Version Manager](https://github.com/nvm-sh/nvm)

## Local Build Examples

```bash
cd php/base
docker build --file Dockerfile-8.0 .
```
or
```bash
docker build --file php\base\Dockerfile-8.0 .\php\base
```

## Plans

- Will likely drop debian 7 "wheezy" as the build process is broken and would require quite some effort to get it up 
and running again.
- switch to debian 10 "buster" for all php images. 





<!-- link targets -->
[sury]: https://deb.sury.org/
[dotdeb]: https://www.dotdeb.org/
[debian]: https://www.debian.org/
[shield.io]: https://shields.io/
[php]: https://www.php.net/
[symfony]: https://symfony.com/
[gitlab]: https://gitlab.com/
