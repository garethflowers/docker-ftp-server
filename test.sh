#!/bin/sh
set -xe
export IMAGE_NAME=garethflowers/ftp-server

docker build --tag $IMAGE_NAME .
docker run --rm $IMAGE_NAME sh -c 'vsftpd -version 0>&1'

echo "\nOK"
