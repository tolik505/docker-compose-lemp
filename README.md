docker-compose-lemp
===========

Based on laradock.

## Features:

1. Nginx is configured to automatically resolve all domains ending with `.dev`.
It is very convenient: you can simply create the directory `test-app` (domain name without `.dev`) in the
web document root and it will be available by the link `http://test-app.dev/` (NOTICE: it requires some preliminary
configuration, see #additional software for detailed information).

2. MariaDB 5.5.54
   * user: root
   * password: root
   
3. Phpmyadmin

4. Redis

5. Workspace with pre-installed `composer`, `git`, `ssh`, `node 6.11.2`, `yarn`.

6. It stores source codes, mysql data and ssh keys on the host machine, therefore, you don't need to deploy your app each
time you start container.

7. Php process run by user with UID 1000 (by default, the same UID as your host machine user),
thus it can access all files. At the same time, you have all permissions for generated files.

Some configurations can be changed in your environment file .env

# How to use

First of all, you need install [Docker Engine and Docker Compose](https://www.docker.com/) on your machine. 


1 - Enter the folder of the cloned repository and copy `env-example` to `.env`

```shell
cp env-example .env
```

Change the variable USER_NAME according your system username (it's for ssh folder mapping).
Actually, you can edit the `.env` file to chose which software's you want to be installed in your environment. You can always refer to the `docker-compose.yml` file to see how those variables are been used.


2 - Build the environment and run it using `docker-compose`

To run containers execute command:

```bash
docker-compose up -d
```

To stop containers execute command:

```bash
docker-compose down
```

To rebuild containers execute command:

```bash
docker-compose build
```

<br>
3 - Enter the Workspace container, to execute commands like (Artisan, Composer, Gulp, ...) as your host's user

```shell
docker-compose exec --user=laradock workspace bash
```

But if you need `root` privileges, run:

```bash
docker-compose exec workspace bash
```

## additional software

For comfortable work, I suggest you to use [dnsmasq](https://en.wikipedia.org/wiki/Dnsmasq) for automatic resolving of such domains as `http://*.dev/`.
You can install it in Ubuntu this way (run as `root`):

    apt-get install dnsmasq
    echo "address=/.dev/127.0.0.1" >> /etc/dnsmasq.conf

Another variant is to update `/etc/hosts` manually, each time adding something like this:

    127.0.0.1   my-app.dev

