nginx RTMP restream server
==========================

This repository provides a set of scripts and templates to use [Nginx](https://www.nginx.com/)
and [nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module) for RTMP restream server,
which allows you to stream a single RTMP publish such as from [OBS](https://obsproject.com/)
to multiple destinations such as [Twitch](https://www.twitch.tv/), [Twitter (Periscope)](https://www.pscp.tv).

Target environment is macOS and it depends on Homebrew package managers.

Prerequisites
-------------

Install next formulas by using [Homebrew](https://brew.sh/).

- `nginx`
- `ffmpeg` (For now, it is required but only for Twitter (Periscope))

Also you need a command line tools.
If you don't have it, use next command to install it.

```
xcode-select --install
```

Build
-----

Use `make` to build `nginx-rtmp-module`.

```
make
```

Configuration
-------------

Copy `config.yml.example` to `config.yml`, then edit it.
See inline comment for each parameter.

Usage
-----

Use `make` to run `nginx` with the configuration.

```
make run
```
