#!/bin/bash

WORK_DIR=/home/`logname`

mkdir -p $WORK_DIR/rancher
chmod 755 $WORK_DIR/rancher
docker run -d --privileged --restart=unless-stopped -p 80:80 -p 443:443 -v $WORK_DIR/rancher:/var/lib/rancher rancher/rancher:stable
