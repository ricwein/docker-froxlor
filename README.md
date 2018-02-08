![Docker Build Status](https://img.shields.io/docker/build/ricwein/froxlor.svg)

# An experimental Froxlor Docker-Image

This Images aims at providing a containerized [froxlor Server](https://www.froxlor.org/), including all configurable services as Containers (which is currenlty **work in progress!**).
## Docker-Hub

[hub.docker.com/r/ricwein/froxlor/](https://hub.docker.com/r/ricwein/froxlor/)

## Starting up


### One-Shot

The fastest way to getting started with froxlor is just using the following command to start a standalone container.

```shell
docker run --name froxlor -d -p 8080:80 ricwein/froxlor:latest
```

However, this setup requires a separated mysql-server to host froxlors internal database. In addition, all configurations which are done through froxlor will **not persists** if you delete the container.

### Persistent usage

The [source-repository](https://github.com/ricwein/docker-froxlor) not only contains the used `Dockerfile` for the froxlor-image, but also a preconfigured `docker-compose.yml` which links against a [mariadb](https://hub.docker.com/_/mariadb/) container.

After cloning the repository, you can use `docker-compose` to start the required containers, or add other services.

```shell
git clone --recursive https://github.com/ricwein/docker-froxlor
cd docker-froxlor
```

To allow a persistent usage of the containers, the froxlor source-code is added as an git-submodule, which is mounted as a volume into the container (`froxlor` dir). This also allows updating froxlor itself through the repository, without rebuilding the image. Next to froxlor, the mariadb volume is mounted into the `database` dir.

#### Preconfiguration (optional)

If wished, you can reconfigure the default mysql credentials by editing the `db.env` file.

#### Run

```shell
docker-compose up -d
```

Done. Froxlor is now running and reachable under [localhost:8080](http://localhost:8080).

#### Setup

After starting froxlor the first time, it requires to be configured through its website:

![Froxlor Setup Website](https://raw.githubusercontent.com/ricwein/docker-froxlor/master/images/setup.png)

We can use the following default credentials (if we use the unchanged `docker-compose.yml` with the mariadb-container and default `db.env`)

| name | value |
|---|---|
| MySQL-Hostname | `database` |
| Database name | `froxlor` |
| Username for the unprivileged MySQL-account | `froxlor` |
| Password for the unprivileged MySQL-account | `froxlor` |
| Username for the MySQL-root-account | `root` |
| Password for the MySQL-root-account | `toor` |

All the other values can be configured as desired. Just ensure `Apache 2.4` is selected under **Server settings**.

## Setup Services

At this state, we have a running apache webserver, along with php7 and some php-modules in our froxlor container and a mariadb mysql-server in another container.

### Inside the froxlor-container

The simplest way of installing other services is probably by installing them directly into the froxlor container.

> **Be aware!:** this does not persist through container recreations! Therefor this is not recommended.

```shell
docker exec -it dockerfroxlor_froxlor_1 /bin/bash
```

The froxlor image inherits from debian (stretch) which allows the usage of `apt`/`apt-get` to install packages.

### Using Service-Containers

The best way to add services is as Docker-containers. Since docker-containers are sandboxed and froxlor requires filesystem-access to service-config-files, this way is currently *work in progress* only. Maybe feature releases will support this. Until then: Please feel free to contribute your own solutions.
