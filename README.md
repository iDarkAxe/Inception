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

```txt
DB_NAME=here-a-db-name
DB_USER=here-a-user
WORDPRESS_DB_HOST=here-a-db-host-name
```

To use the secrets, create a folder `./secrets` and create two files inside (`db_password.txt` and `db_root_password.txt`).

> [:warning: !WARNING :warning:] <br>
> Please use strong password and don't push your .env or secrets. It's not safe.
