# Inception #

A project to learn Docker as a System Administrator.
It's mainly 3 Docker Containers assembled with a `compose.yml` file.

If you don't have all the rights/permissions on your HOST, you should set a VM. The VM is the REMOTE in this case.

## Usage ##

The only way to access the containers is by accessing the url from the nginx server. It could be `https://localhost/` or `https://username.42.fr` if you setupd `/etc/hosts` to point to `127.0.0.1` if the address is requested.

## Installation ##

You will need to use `docker`, if you don't have permissions to execute `docker compose` or anything related, please use a VM.

To properly setup the project, you need to create a `.env` file in `srcs/`. Fill the `here_*` with your values. You can also just modify the `.env.template` file into `.env` and modify the values.
`OPENSSL_SUBJ` is only required for building images. `CN` as Common Name or server FQDN (Fully qualified domain name) could be simply `www.example.com`.

If you don't specify all the VARS, the build will stop. If you accept the risk, you can remove in the `compose.yml` file the `:?` after each environment varriable.

```txt
MYSQL_DATABASE=here_database_name
MYSQL_USER=here_user_for_db
WORDPRESS_DB_PASSWORD=here_password
WORDPRESS_DB_HOST=here_db_host:here_port
OPENSSL_SUBJ=/C=here_country/ST=here_state/L=here_locality/O=here_organisation/OU=here_organisation_unit/CN=here_common_name
URL=here_username.here_domain.here_country_code
WORDPRESS_ADMIN_USERNAME=here_admin_username
WORDPRESS_ADMIN_PASSWORD=here_admin_password
WORDPRESS_ADMIN_EMAIL=here_admin_email@domain.com
WORDPRESS_BASIC_USER_USERNAME=here_basic_username
WORDPRESS_BASIC_USER_PASSWORD=here_basic_password
WORDPRESS_BASIC_USER_EMAIL=here_basic_email@domain.com
WP_INSTALL_PATH=/path/of/wordpress
FTP_USERNAME=here_ftp_username
FTP_PASSWORD=here_ftp_password
HOST_DATA_PATH=/here_path
```

### Examples ###

-  `WORDPRESS_DB_HOST`=`mariadb:3306`, a service name is also hostname
-  `WP_INSTALL_PATH`=`/website/wordpress`
-  `HOST_DATA_PATH`=`/home/login/`

## Virtual Machines ##

If you are using a virtual machines, these commands will help you.

### How to send this project to your REMOTE ###

If you are working on the project, you should work on HOST as all your tools are already installed. You should only build and execute on REMOTE.
If it's not present :

```sh
make save
```

### List of commands ###

For Alpine OS users, you should have not run in live mode, an install is better for repeatability. You also need to enable Community packages, remove the starting `#` in the file `/etc/apk/repositories`. You will need theses tools for the project.
For other OSes, you can replace `apk add` with `apt install` or anything of your choice that uses a package manager.

```sh
setup-alpine
poweroff
```

```sh
apk update
apk add nano
apk add docker
apk add docker-compose
apk add rsync
apk add make
```

### For X11 Forwarding ###

Followed this tuto <https://some-natalie.dev/blog/ssh-x11-forwarding/>

If you need to use a browser like Firefox from inside (remote), you also need to install the following font as they are not marked as dependancies (you will see strange characters if you don't install them).

```sh
apk add font-noto font-noto-cjk font-dejavu font-liberation font-adobe-100dpi fontconfig
fc-cache -f -v
```

To access the VM with the following command :

```sh
ssh -XC -p <port> <user>@<ip_address>
```

- `X` means that X11 will forward applications to the client (you).
- `C` means that it will attemps to compress data (it helps reduce network bandwith but increase CPU usage).
- `p` is useful if you already are using default port of ssh (22).

### Resources ###

- <https://wiki.alpinelinux.org/wiki/Nginx>
- <https://wiki.alpinelinux.org/wiki/MariaDB>
- <https://wiki.alpinelinux.org/wiki/WordPress>
- <https://kinsta.com/fr/blog/adminer/>
- <https://wiki.alpinelinux.org/wiki/FTP>
- <https://technologytales.com/turning-off-seccomp-sandbox-in-vsftpd/>
- <https://wp-cli.org/fr/>
- <https://make.wordpress.org/cli/handbook/guides/installing/>
- <https://www.php.net/manual/en/book.phar.php>
- <https://docs.docker.com/compose/how-tos/environment-variables/variable-interpolation/> : for required environnment variables in `compose.yml`
- <https://docs.docker.com/reference/compose-file/services/#healthcheck>
- <https://docs.docker.com/engine/storage/bind-mounts/>
- <https://nginx.org/en/docs/http/ngx_http_fastcgi_module.html>
