docker build --no-cache --tag ftp .
docker rm -fv ftp
# docker run -d -p 20-21:20-21/tcp -p 40000-40009:40000-40009/tcp --env FTP_USER=ftp-user --env FTP_PASS=ftp-pass --name ftp --restart always docker.io/garethflowers/ftp-server:0.1.0
