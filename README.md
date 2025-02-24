# windoac/bind

forked from [sameersbn/docker-bind](https://github.com/sameersbn/docker-bind)

Most of the setting should be same.

## new add feature for this forked

1. Supported cron. Will save the current crontab content/job when the container stops and load it when starts.
2. Option to run the bind(named) with option `-f` instead of `-g`

### 2. Option to run the bind(named) with option `-f` instead of `-g`

* `BIND_LOG_STDERR`: If BIND send the log to STDERR or not. Defaults to `true`. 
   If you do when to output log to file, set this to false.

## info

dockerhub forked from [sameersbn/bind](https://hub.docker.com/r/sameersbn/bind)

Dockerfile see https://github.com/WindoC/docker-bind/blob/master/Dockerfile

docker-cmpose.yml example see 

# from forked sameersbn/docker-bind

## Installation

```bash
docker pull windoac/bind:latest
```

Alternatively you can build the image yourself.

```bash
docker build -t docker-bind .

# test run
docker run -it --rm -p 10000:10000 -p 53:53 -p 53:53/udp docker-bind
```

## Quickstart

Start BIND using:

```bash
docker run --name bind -d --restart=always \
  --publish 53:53/tcp --publish 53:53/udp --publish 10000:10000/tcp \
  --volume /srv/docker/bind:/data \
  windoac/bind:latest
```

*Alternatively, you can use the sample [docker-compose.yml](docker-compose.yml) file to start the container using [Docker Compose](https://docs.docker.com/compose/)*

When the container is started the [Webmin](http://www.webmin.com/) service is also started and is accessible from the web browser at https://localhost:10000. Login to Webmin with the username `root` and password `password`. Specify `--env ROOT_PASSWORD=secretpassword` on the `docker run` command to set a password of your choosing.

The launch of Webmin can be disabled by adding `--env WEBMIN_ENABLED=false` to the `docker run` command. Note that the `ROOT_PASSWORD` parameter has no effect when the launch of Webmin is disabled.

Read the blog post [Deploying a DNS Server using Docker](http://www.damagehead.com/blog/2015/04/28/deploying-a-dns-server-using-docker/) for an example use case.

## Command-line arguments

You can customize the launch command of BIND server by specifying arguments to `named` on the `docker run` command. For example the following command prints the help menu of `named` command:

```bash
docker run --name bind -it --rm \
  --publish 53:53/tcp --publish 53:53/udp --publish 10000:10000/tcp \
  --volume /srv/docker/bind:/data \
  windoac/bind:latest -h
```

## Persistence

For the BIND to preserve its state across container shutdown and startup you should mount a volume at `/data`.

> *The [Quickstart](#quickstart) command already mounts a volume for persistence.*

SELinux users should update the security context of the host mountpoint so that it plays nicely with Docker:

```bash
mkdir -p /srv/docker/bind
chcon -Rt svirt_sandbox_file_t /srv/docker/bind
```

## Reverse Proxying

If you need to run Webmin behind a reverse-proxy such as Nginx, you can tweak the following environment variables:

* `WEBMIN_INIT_SSL_ENABLED`: If Webmin should be served via SSL or not. Defaults to `true`. 
   If you do the SSL termination at an earlier stage, set this to false.

* `WEBMIN_INIT_REDIRECT_PORT`: The port Webmin is served from. 
   Set this to your reverse proxy port, such as `443`. Defaults to `10000`.

* `WEBMIN_INIT_REFERERS`: Sets the allowed referrers to Webmin. 
   Set this to your domain name of the reverse proxy. Example: `mywebmin.example.com`. 
   Defaults to empty (no referrer).

# Maintenance

## Upgrading

To upgrade to newer releases:

  1. Download the updated Docker image:

  ```bash
  docker pull windoac/bind:latest
  ```

  2. Stop the currently running image:

  ```bash
  docker stop bind
  ```

  3. Remove the stopped container

  ```bash
  docker rm -v bind
  ```

  4. Start the updated image

  ```bash
  docker run -name bind -d \
    [OPTIONS] \
    windoac/bind:latest
  ```

## Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version `1.3.0` or higher you can access a running containers shell by starting `bash` using `docker exec`:

```bash
docker exec -it bind bash
```

## check if there are new verion

### bind9

```
docker run -it --rm ubuntu:24.04 bash
apt update
apt search bind9
```

### webmin

Access webmin page to check. https://webmin.com/
