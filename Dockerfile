FROM alpine:3.12

ENV FTP_USER=foo \
	FTP_PASS=bar

RUN apk add --no-cache --update \
	vsftpd==3.0.3-r6

COPY [ "/vsftpd.conf", "/etc" ]
COPY [ "/docker-entrypoint.sh", "/" ]

CMD [ "/usr/sbin/vsftpd" ]
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 21
