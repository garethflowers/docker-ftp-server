# FTP Server

A simple FTP server, using `vsftpd`.

## How to use this image

### Start a FTP Server instance

To start a container, with data stored in `/data` on the host, use the following:
```sh
docker run \
	--name my-ftp-server \
	--detach \
	--env FTP_USER=user \
	--env FTP_PASS=123 \
	--volume /data:/home/user \
	--publish 21:21 \
	garethflowers/ftp-server
```

## License

*	This image is released under the [MIT License](https://raw.githubusercontent.com/garethflowers/docker-ftp-server/master/LICENSE).
