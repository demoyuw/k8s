#!/bin/bash

WORK_DIR=/home/demoyuw
LOGFILE=$WORK_DIR/log/docker_install.log
mkdir -p $WORK_DIR/log
touch $LOGFILE

apt-get update -y &>> $LOGFILE
apt-get install     apt-transport-https     ca-certificates     curl     software-properties-common -y &>> $LOGFILE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &>> $LOGFILE
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" &>> $LOGFILE
apt-get update -y &>> $LOGFILE 
apt-get install docker-ce -y &>> $LOGFILE
usermod -aG docker demoyuw &>> $LOGFILE
su - demoyuw
