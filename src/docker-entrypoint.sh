#!/bin/sh


adduser \
	-D \
	-G ftp \
	-h /home/$FTP_USER \
	-s /bin/false \
	$FTP_USER

mkdir -p /home/$FTP_USER
chown -R $FTP_USER:ftp /home/$FTP_USER
echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd

exec "$@"
