#!/bin/bash

WORK_DIR=/home/demoyuw
LOGFILE=$WORK_DIR/log/rancher_install.log
mkdir -p $WORK_DIR/log
touch $LOGFILE

apt-get update -y &>> $LOGFILE
apt-get install     apt-transport-https     ca-certificates     curl     software-properties-common  -y &>> $LOGFILE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &>> $LOGFILE
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" &>> $LOGFILE
apt-get update -y &>> $LOGFILE 
apt-get install docker-ce -y &>> $LOGFILE
usermod -aG docker demoyuw &>> $LOGFILE

mkdir -p $WORK_DIR/rancher &>> $LOGFILE
chmod 755 $WORK_DIR/rancher &>> $LOGFILE
docker run -d --privileged --restart=unless-stopped -p 80:80 -p 443:443 -v $WORK_DIR/rancher:/var/lib/rancher rancher/rancher:stable &>> $LOGFILE
