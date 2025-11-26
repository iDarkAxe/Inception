#!/bin/ash

# -e = exit on error, -u = undefined var = error
set -eu

: "${USER_NAME:?USER_NAME not set}"
: "${USER_PASSWORD:?USER_PASSWORD not set}"

# Create dirs
mkdir -p /var/ftp
mkdir -p /var/ftp/data
mkdir -p /var/ftp/website

# Create user with chroot = /var/ftp
if ! id "${USER_NAME}" >/dev/null 2>&1; then
    adduser -D -h /var/ftp "${USER_NAME}"
    echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd
	echo "${USER_NAME}" >> /etc/vsftpd.userlist
fi

# Chroot must be owned by root
chown root:root /var/ftp
chmod 755 /var/ftp

# User writable directory
chown "${USER_NAME}:${USER_NAME}" /var/ftp/data

exec vsftpd /etc/vsftpd/vsftpd.conf
