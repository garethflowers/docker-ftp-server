FROM alpine:3.12

LABEL org.opencontainers.image.authors="Gareth Flowers" \
	org.opencontainers.image.description="FTP Server" \
	org.opencontainers.image.licenses="MIT" \
	org.opencontainers.image.title="ftp-server" \
	org.opencontainers.image.url="https://github.com/garethflowers/docker-ftp-server" \
	org.opencontainers.image.vendor="garethflowers"

ENV FTP_USER=foo \
	FTP_PASS=bar

RUN apk add --no-cache --update \
	vsftpd==3.0.3-r6

COPY [ "/vsftpd.conf", "/etc" ]
COPY [ "/docker-entrypoint.sh", "/" ]

CMD [ "/usr/sbin/vsftpd" ]
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 21
