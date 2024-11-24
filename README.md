# FTP Server

A simple FTP server, using
[`vsftpd`](https://security.appspot.com/vsftpd.html).

## How to use this image

### Start a FTP Server instance

To start a container, with data stored in `/data` on the host, use the
following:

#### ... via `docker run`

```sh
docker run \
	--detach \
	--env FTP_PASS=123 \
	--env FTP_USER=user \
	--env PUBLIC_IP=192.168.0.1 \
	--name my-ftp-server \
	--publish 20-21:20-21/tcp \
	--publish 40000-40009:40000-40009/tcp \
	--volume /data:/home/user \
	garethflowers/ftp-server
```

#### ... via `docker compose`

```yml
services:
	ftp-server:
		container_name: my-ftp-server
		environment:
			- PUBLIC_IP=192.168.0.1
			- FTP_PASS=123
			- FTP_USER=user
		image: garethflowers/ftp-server
		ports:
			- "20-21:20-21/tcp"
			- "40000-40009:40000-40009/tcp" # For passive mode
		volumes:
			- "/data:/home/user"
```

## Configuration

### Ports

| Port           | Required? | Description                                                     | Config                                                                                                                                         |
| -------------- | --------- | --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| 21             | Required  | The default port that FTP listens on.                           | [listen_port](https://security.appspot.com/vsftpd/vsftpd_conf.html)                                                                            |
| 20             | Required  | The default port for PORT connections to originate.             | [ftp_data_port](https://security.appspot.com/vsftpd/vsftpd_conf.html)                                                                          |
| 40000<br>40009 | Optional  | The min and max ports to use for PASV connections to originate. | [pasv_min_port](https://security.appspot.com/vsftpd/vsftpd_conf.html)<br>[pasv_max_port](https://security.appspot.com/vsftpd/vsftpd_conf.html) |

### Environment Variables

| Variable    | Default Value | Description                                       |
| ----------- | ------------- | ------------------------------------------------- |
| `FTP_PASS`  | `bar`         | The FTP password                                  |
| `FTP_USER`  | `foo`         | The FTP username                                  |
| `PUBLIC_IP` | `0.0.0.0`     | Public IP address to use for Passive connections. |

## License

-   This image is released under the
    [MIT License](https://raw.githubusercontent.com/garethflowers/docker-ftp-server/master/LICENSE).
