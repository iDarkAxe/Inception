# Inception #

A project to learn Docker as a System Administrator.
It's mainly 3 Docker Containers assembled with a `compose.yml` file.

## Usage ##

The only way to access the containers is by accessing the url from the nginx server. It could be `https://localhost/` or `https://username.42.fr` if you setupd `/etc/hosts` to point to `127.0.0.1` if the address is requested.

If you are using a VM, you can access the VM with the following command :

```sh
ssh -XC -p <port> <user>@<ip_address>
```

- `X` means that X11 will forward applications to the client (you).
- `C` means that it will attemps to compress data (it helps reduce network bandwith but increase CPU usage).
- `p` is useful if you already are using default port of ssh (22).

## Installation ##

You will need to use `docker`, if you don't have permissions to execute `docker compose` or anything related, please use a VM.

To properly setup the project, you need to create a `.env` file in `srcs/`. Fill the `here-*` with your values.
`OPENSSL_SUBJ` is only required for building images. `CN` as Common Name or server FQDN (Fully qualified domain name) could be simply `www.example.com`.

If you don't specify all the VARS, the build will stop. If you accept the risk, you can remove in the `compose.yml` file the `:?` after each environment varriable.

```txt
MYSQL_DATABASE=here-database-name
MYSQL_USER=here-user-for-db
WORDPRESS_DB_PASSWORD=here-password
WORDPRESS_DB_HOST=here-db-host:here-port
OPENSSL_SUBJ=C=here-country/ST=here-state/L=here-locality/O=here-organisation/OU=here-organisation-unit/CN=here-common-name
```
