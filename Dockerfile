FROM alpine:3.12.0

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

COPY [ "/src/vsftpd.conf", "/etc" ]
COPY [ "/src/docker-entrypoint.sh", "/" ]

CMD [ "/usr/sbin/vsftpd" ]
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 20/tcp 21/tcp 40000-50000/tcp
HEALTHCHECK CMD netstat -lnt | grep :21 || exit 1
