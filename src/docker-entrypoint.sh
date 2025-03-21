#!/bin/sh
FTP_DATA=/home/$FTP_USER
FTP_GROUP=$( getent group "$GID" | awk -F ':' '{print $1}' )
VSFTPD_CONF=/etc/vsftpd.conf

if test -z "$FTP_GROUP"; then
	FTP_GROUP=$FTP_USER
	addgroup -g "$GID" -S "$FTP_GROUP"
fi

adduser -D -G "$FTP_GROUP" -h "$FTP_DATA" -s "/bin/false" -u "$UID" "$FTP_USER"

mkdir -p $FTP_DATA
chown -R "$FTP_USER:$FTP_GROUP" "$FTP_DATA"
echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd

env | grep -q '^VSFTPD_' && echo "Updating ${VSFTPD_CONF} from environment"
env \
| grep '^VSFTPD_' \
| sed -e 's/^VSFTPD_//' \
| while read envvar; do
      varname="$( echo "$envvar" | cut -d= -f 1  )"
      value="$(   echo "$envvar" | cut -d= -f 2- )"

      if grep -q -e "^${varname}[[:space:]]*=" "$VSFTPD_CONF"; then
          echo "Updating $envvar"
          sed -ri "s/^${varname}[[:space:]]*=.*/${varname}=${value}/" "$VSFTPD_CONF"
      else
          echo "Adding $envvar"
          echo "${varname}=${value}" >>"$VSFTPD_CONF"
      fi
done

sed -i -r "s/0.0.0.0/$PUBLIC_IP/g" /etc/vsftpd.conf

touch /var/log/vsftpd.log
tail -f /var/log/vsftpd.log | tee /dev/stdout &
touch /var/log/xferlog
tail -f /var/log/xferlog | tee /dev/stdout &

exec "$@"
